//
//  ChartView.swift
//  WHAT_IS_MONEY
//
//  Created by 이예나 on 1/11/23.
//

//import UIKit
import SwiftUI

struct PieChartCell: Shape {
    let startAngle: Angle
    let endAngle: Angle
   func path(in rect: CGRect) -> Path {
        let center = CGPoint.init(x: (rect.origin.x + rect.width)/2, y: (rect.origin.y + rect.height)/2)
    let radii = min(center.x, center.y)
        let path = Path { p in
            p.addArc(center: center,
                     radius: radii,
                     startAngle: startAngle,
                     endAngle: endAngle,
                     clockwise: true)
            p.addLine(to: center)
        }
        return path
   }
}
struct PieChart: View {
    @State private var selectedCell: UUID = UUID()
     
    let dataModel: ChartDataModel
    let onTap: (ChartCellModel?) -> ()
    var body: some View {
        
            ZStack {
                ForEach(dataModel.chartCellModel) { dataSet in
                    PieChartCell(startAngle: self.dataModel.angle(for: dataSet.value), endAngle: self.dataModel.startingAngle)
                        .foregroundColor(dataSet.color)
                       .onTapGesture {
                         withAnimation {
                            if self.selectedCell == dataSet.id {
                                self.onTap(nil)
                                self.selectedCell = UUID()
                            } else {
                                self.selectedCell = dataSet.id
                                self.onTap(dataSet)
                            }
                        }
                    }.scaleEffect((self.selectedCell == dataSet.id) ? 1.05 : 1.0)
                }
            }
    }
}

struct ChartView: View {
    @State var selectedPie: String = ""
    var body: some View {
        ScrollView {
            Text("차트")
                .fontWeight(.bold)
                .font(.system(size: 20))
            VStack(alignment: .leading, spacing: 0) {
                    Text("저번달")
                        .fontWeight(.bold)
                        .font(.system(size: 20))
                        .padding(.top, 20)
                        .padding(.leading, 30)
             
                HStack(spacing: 20){
                    PieChart(dataModel: ChartDataModel.init(dataModel: sample), onTap: {
                        dataModel in
                        if let dataModel = dataModel {
                            self.selectedPie = "종류: \(dataModel.name)\n비율: \(dataModel.value)%"
                        } else {
                            self.selectedPie = ""
                        }
                        
                    })
                    .frame(width: 150, height: 150, alignment: .center)
                    .padding(30)
                    Text(selectedPie)
                        .font(.system(size: 12))
                    .multilineTextAlignment(.leading)
                    Spacer()
                }
                Spacer()
                HStack(alignment: .center) {
                    ForEach(sample) { dataSet in
                        HStack {
                            Rectangle().foregroundColor(dataSet.color).frame(width: 10, height: 10)
                            Text(dataSet.name).font(.footnote)
                        }
                    }
                }.padding(.leading, 30)
            }.padding(.bottom, 20)
            Divider()
            VStack(alignment: .leading, spacing: 0) {
                    Text("이번달")
                        .fontWeight(.bold)
                        .font(.system(size: 20))
                        .padding(.top, 30)
                        .padding(.leading, 30)
             
                HStack(spacing: 20){
                    PieChart(dataModel: ChartDataModel.init(dataModel: sample), onTap: {
                        dataModel in
                        if let dataModel = dataModel {
                            self.selectedPie = "종류: \(dataModel.name)\n비율: \(dataModel.value)%"
                        } else {
                            self.selectedPie = ""
                        }
                        
                    })
                    .frame(width: 150, height: 150, alignment: .center)
                    .padding(30)
                    Text(selectedPie)
                        .font(.system(size: 12))
                    .multilineTextAlignment(.leading)
                    Spacer()
                }
                Spacer()
                HStack(alignment: .center) {
                    ForEach(sample) { dataSet in
                        HStack {
                            Rectangle().foregroundColor(dataSet.color).frame(width: 10, height: 10)
                            Text(dataSet.name).font(.footnote)
                        }
                    }
                }.padding(.leading, 30)
            }
        }
        
    }

}
struct ChartCellModel: Identifiable {
    let id = UUID()
    let color: Color
    let value: CGFloat
    let name: String
}
final class ChartDataModel: ObservableObject {
    var chartCellModel: [ChartCellModel]
    var startingAngle = Angle(degrees: 0)
    private var lastBarEndAngle = Angle(degrees: 0)
     
         
    init(dataModel: [ChartCellModel]) {
        chartCellModel = dataModel
    }
     
    var totalValue: CGFloat {
        chartCellModel.reduce(CGFloat(0)) { (result, data) -> CGFloat in
            result + data.value
        }
    }
     
    func angle(for value: CGFloat) -> Angle {
        if startingAngle != lastBarEndAngle {
            startingAngle = lastBarEndAngle
        }
        lastBarEndAngle += Angle(degrees: Double(value / totalValue) * 360 )
        print(lastBarEndAngle.degrees)
        return lastBarEndAngle
    }
}

let sample = [ ChartCellModel(color: Color("NPeach"), value: 40, name: "고정지출"),
               ChartCellModel(color: Color("NOrange"), value: 10, name: "배달음식"),
               ChartCellModel(color: Color("NYellow"), value: 20, name: "의류"),
               ChartCellModel(color: Color("NGreen"), value: 10, name: "식재료"),
               ChartCellModel(color: Color("NBlue"), value: 20, name: "교통")]

struct ChartView_Previews: PreviewProvider{
    static var previews: some View {
        ChartView()
    }
}
