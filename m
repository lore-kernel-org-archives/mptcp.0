Received: from rn-mailsvcp-mx-lapp01.apple.com (rn-mailsvcp-mx-lapp01.apple.com [17.179.253.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD79AD2E
	for <mptcp@lists.linux.dev>; Mon, 11 Sep 2023 17:41:32 +0000 (UTC)
Received: from rn-mailsvcp-mta-lapp01.rno.apple.com
 (rn-mailsvcp-mta-lapp01.rno.apple.com [10.225.203.149])
 by rn-mailsvcp-mx-lapp01.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023)) with ESMTPS id <0S0U007WI151U830@rn-mailsvcp-mx-lapp01.rno.apple.com>
 for mptcp@lists.linux.dev; Mon, 11 Sep 2023 10:41:26 -0700 (PDT)
X-Proofpoint-ORIG-GUID: AxE00cqSYTcr41q9ILrvttKtKORNHET4
X-Proofpoint-GUID: AxE00cqSYTcr41q9ILrvttKtKORNHET4
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.601,18.0.957
 definitions=2023-09-11_13:2023-09-05,2023-09-11 signatures=0
X-Proofpoint-Spam-Details: rule=interactive_user_notspam
 policy=interactive_user score=0 mlxscore=0 mlxlogscore=432 phishscore=0
 suspectscore=0 malwarescore=0 spamscore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309110161
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com;
 h=content-type : mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to; s=20180706;
 bh=/UmKWMEBZ8YoIn4Prq5QVdDMPky+8pQEkn1Nazk9DFo=;
 b=fQwtBZEt6NeHDFHoOrbkNVfYJFLhUipcK1KGG61WN4/oxc2pYFu/2BrzShuduSmCXwoO
 8Fgtw7fNGE5jsdlRFhZ1VXx0MohXzoIJlw+w5+/Pvq2AytpyXIadtp9bZ6OjxreOVvd7
 muqozt6xqtBa4DO0coZFlEMY6Vx+fUBPDYXlthd0Uv/yWvur26bwDheUjk1733tDM6nv
 qedrIYvbYLuUZvshEjuRSBAZNX1MWBlK09KtXHbvcICBrzm2EKDxBeXphiveIDbA7Yli
 rgqAU876Fv/ME9td1SsqPbjDe0O0T3Dp9HP1rEMe16EJKGExuEa+85pIahEj2Ou7KTbB rQ==
Received: from rn-mailsvcp-mmp-lapp02.rno.apple.com
 (rn-mailsvcp-mmp-lapp02.rno.apple.com [17.179.253.15])
 by rn-mailsvcp-mta-lapp01.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023)) with ESMTPS id <0S0U00KPX15226N0@rn-mailsvcp-mta-lapp01.rno.apple.com>;
 Mon, 11 Sep 2023 10:41:26 -0700 (PDT)
Received: from process_milters-daemon.rn-mailsvcp-mmp-lapp02.rno.apple.com by
 rn-mailsvcp-mmp-lapp02.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023)) id <0S0U010000JMDQ00@rn-mailsvcp-mmp-lapp02.rno.apple.com>; Mon,
 11 Sep 2023 10:41:26 -0700 (PDT)
X-Va-A:
X-Va-T-CD: 62d7da425da0fb25eb2c6e85f2f966df
X-Va-E-CD: 2b3483cc51d778a83b3be5915b056b7f
X-Va-R-CD: 0eef42286f64395431e9696be9476630
X-Va-ID: daf03f73-4073-45cc-b467-f9fce56a1f6b
X-Va-CD: 0
X-V-A:
X-V-T-CD: 62d7da425da0fb25eb2c6e85f2f966df
X-V-E-CD: 2b3483cc51d778a83b3be5915b056b7f
X-V-R-CD: 0eef42286f64395431e9696be9476630
X-V-ID: 4176f744-5b3c-4770-bd89-f4f26dea2cf8
X-V-CD: 0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.601,18.0.957
 definitions=2023-09-11_13:2023-09-05,2023-09-11 signatures=0
Received: from smtpclient.apple ([17.192.155.113])
 by rn-mailsvcp-mmp-lapp02.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023))
 with ESMTPSA id <0S0U00W081514M10@rn-mailsvcp-mmp-lapp02.rno.apple.com>; Mon,
 11 Sep 2023 10:41:26 -0700 (PDT)
Content-type: text/plain; charset=utf-8
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-version: 1.0 (Mac OS X Mail 16.0 \(3774.100.2.1.2\))
Subject: Re: kmemleak handling of kfree_rcu
From: Christoph Paasch <cpaasch@apple.com>
In-reply-to:
 <CAEXW_YTxLRAKCpFdKOdegj0gZdBb0OH+BnJf9FGTGfPtwiPkiw@mail.gmail.com>
Date: Mon, 11 Sep 2023 10:41:15 -0700
Cc: Catalin Marinas <catalin.marinas@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 MPTCP Upstream <mptcp@lists.linux.dev>, rcu@vger.kernel.org
Content-transfer-encoding: quoted-printable
Message-id: <26A7E7B0-8B40-465C-9FC6-6F3D6529A591@apple.com>
References: <F903A825-F05F-4B77-A2B5-7356282FBA2C@apple.com>
 <ZPZKsJUPVeHCsLQB@arm.com> <EDE8FE3D-043D-4A14-ACF6-71FF786C0D32@apple.com>
 <ZPi1LvrcGcSKBLqR@arm.com>
 <CAEXW_YTxLRAKCpFdKOdegj0gZdBb0OH+BnJf9FGTGfPtwiPkiw@mail.gmail.com>
To: Joel Fernandes <joel@joelfernandes.org>
X-Mailer: Apple Mail (2.3774.100.2.1.2)

Hello,

> On Sep 10, 2023, at 4:10=E2=80=AFPM, Joel Fernandes =
<joel@joelfernandes.org> wrote:
>=20
> Hi Christoph,
>=20
> On Wed, Sep 6, 2023 at 1:21=E2=80=AFPM Catalin Marinas =
<catalin.marinas@arm.com> wrote:
>>=20
>> On Tue, Sep 05, 2023 at 02:22:13PM -0700, Christoph Paasch wrote:
> [..]
>>> If you have an updated patch, let me know. I can test it.
>>=20
>> I sent it in reply to Joel.
>=20
> Just checking if you got a chance to try Catalin's patch?

sorry for the delay! Yes, I tested it and it works!

 Thanks,
Christoph

>=20
> thanks,
>=20
> - Joel
>=20

