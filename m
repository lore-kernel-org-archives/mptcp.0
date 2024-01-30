Received: from ma-mailsvcp-mx-lapp03.apple.com (ma-mailsvcp-mx-lapp03.apple.com [17.32.222.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0CC79DD6
	for <mptcp@lists.linux.dev>; Tue, 30 Jan 2024 20:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.32.222.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706648181; cv=none; b=fctQyRYoNHpAIeCFgcrRQ1NSJ41kj/b4RNEWtv4OQp28mWsg7tMg5BHfRBANzVfcf0vTpJde9kcO8K40+fdBXIGPVNHIkqiP3YBxyT8DPPeUZGvwLx209Zxg2WPkeqJI2HHao27jZOFjNiEAdJw0RyE0ru0QvOph53j4ifLiPyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706648181; c=relaxed/simple;
	bh=h5xt61pOK68xQ7L/suQPcPQrDA+umCMx5fjPfdcCO8I=;
	h=Content-type:MIME-version:Subject:From:In-reply-to:Date:Cc:
	 Message-id:References:To; b=OOdW2+k8gkDssfB3jbHxs/SR7Ob/gj968QUWAWU09Uj8dnNmv7mIfUbvnQJ27+5e1NLblsjmgUA2J2b4MYG0hdPtYAws+77XZL39gEPA7zFlCYI79JhUJfkq7ttg1wmSA5p5upViVPHuiDkv08bHR9Cb79XggSVX1wwgapfq1Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=apple.com; spf=pass smtp.mailfrom=apple.com; dkim=pass (2048-bit key) header.d=apple.com header.i=@apple.com header.b=gV0NlO6Q; arc=none smtp.client-ip=17.32.222.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=apple.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=apple.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=apple.com header.i=@apple.com header.b="gV0NlO6Q"
Received: from rn-mailsvcp-mta-lapp02.rno.apple.com
 (rn-mailsvcp-mta-lapp02.rno.apple.com [10.225.203.150])
 by ma-mailsvcp-mx-lapp03.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023)) with ESMTPS id <0S8300EWNBDDKX00@ma-mailsvcp-mx-lapp03.apple.com> for
 mptcp@lists.linux.dev; Tue, 30 Jan 2024 11:56:12 -0800 (PST)
X-Proofpoint-GUID: Ex8Phl1E7j8LRRsEO13Fh3PqqA691_3k
X-Proofpoint-ORIG-GUID: Ex8Phl1E7j8LRRsEO13Fh3PqqA691_3k
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.619,18.0.1011
 definitions=2024-01-30_09:2024-01-29,2024-01-30 signatures=0
X-Proofpoint-Spam-Details: rule=interactive_user_notspam
 policy=interactive_user score=0 spamscore=0 phishscore=0 bulkscore=0
 adultscore=0 malwarescore=0 mlxlogscore=890 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401300148
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com;
 h=content-type : mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to; s=20180706;
 bh=h5xt61pOK68xQ7L/suQPcPQrDA+umCMx5fjPfdcCO8I=;
 b=gV0NlO6QW0cPbyV+M65ryGnUkRSoiOO54TsG8P2o6t7+xOW/1ypxSELzlqt5Pe5225v1
 tE0o8Usj+NT7R2dWUV7ZbelXG9wdsp25Z3MgU24KBKsQ4iA+JGnfKFHZlt44NmgV4Vt5
 9LzOIC8QOGYF+GrLYZNY2Shh8ECdHA71yk8SOPiAnGE1QLHZbudz+7V6fCal67aU2tvP
 7lJ3YccnL0rAO4tUpMHsrf0WZ1G8w547mvD1nYmFXrCokp9ZjIqsDovx+yly1gqaLqm5
 VfdukVp9X8YJ7BV4oJltCKnRxbROiSCylvifpahnlAc9KIAsS7YrWVCKw5+DD9NbPaXx mA==
Received: from rn-mailsvcp-mmp-lapp03.rno.apple.com
 (rn-mailsvcp-mmp-lapp03.rno.apple.com [17.179.253.16])
 by rn-mailsvcp-mta-lapp02.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023)) with ESMTPS id <0S83009QQBDNVXX0@rn-mailsvcp-mta-lapp02.rno.apple.com>;
 Tue, 30 Jan 2024 11:56:11 -0800 (PST)
Received: from process_milters-daemon.rn-mailsvcp-mmp-lapp03.rno.apple.com by
 rn-mailsvcp-mmp-lapp03.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023)) id <0S8300Z00B8YQ100@rn-mailsvcp-mmp-lapp03.rno.apple.com>; Tue,
 30 Jan 2024 11:56:11 -0800 (PST)
X-Va-A:
X-Va-T-CD: 63633cf878a009867ff2b0b1cd43e165
X-Va-E-CD: 065f87e5e5db2bf8991102f07c5e0146
X-Va-R-CD: 874dbe7a0fa0efb713c0b51e6333f147
X-Va-ID: 66019b66-c713-4b25-83b7-e6d5e937c10b
X-Va-CD: 0
X-V-A:
X-V-T-CD: 63633cf878a009867ff2b0b1cd43e165
X-V-E-CD: 065f87e5e5db2bf8991102f07c5e0146
X-V-R-CD: 874dbe7a0fa0efb713c0b51e6333f147
X-V-ID: df17018a-f2b3-4237-82a3-7d17ab60f62f
X-V-CD: 0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-30_09,2024-01-30_01,2023-05-22_02
Received: from smtpclient.apple ([17.230.192.182])
 by rn-mailsvcp-mmp-lapp03.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023))
 with ESMTPSA id <0S8300J8PBDNIL00@rn-mailsvcp-mmp-lapp03.rno.apple.com>; Tue,
 30 Jan 2024 11:56:11 -0800 (PST)
Content-type: text/plain; charset=utf-8
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-version: 1.0 (Mac OS X Mail 16.0 \(3774.300.61.1.2\))
Subject: Re: [PATCH mptcp-stable] mptcp: introduce explicit flag for first
 subflow disposal
From: Christoph Paasch <cpaasch@apple.com>
In-reply-to: <69dd139b2240fd9ef704a130a952d9643f2148ed.camel@redhat.com>
Date: Tue, 30 Jan 2024 11:56:01 -0800
Cc: mptcp@lists.linux.dev
Content-transfer-encoding: quoted-printable
Message-id: <724F4433-238A-4EDB-A3AE-D483810E2EF9@apple.com>
References:
 <a1503ab571c8c076de62b872437d220a2260d2a5.1706094997.git.pabeni@redhat.com>
 <9B692AAE-74A8-4101-9CDA-2580FCBAC7F0@apple.com>
 <69dd139b2240fd9ef704a130a952d9643f2148ed.camel@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
X-Mailer: Apple Mail (2.3774.300.61.1.2)



> On Jan 30, 2024, at 10:56=E2=80=AFAM, Paolo Abeni <pabeni@redhat.com> =
wrote:
>=20
> On Wed, 2024-01-24 at 09:51 -0800, Christoph Paasch wrote:
>> On Jan 24, 2024, at 3:35=E2=80=AFAM, Paolo Abeni <pabeni@redhat.com> =
wrote:
>>> This is targeting _stable_ and specifically 6.1.65.
>>> I tested vs the repro in:
>>>=20
>>> https://github.com/multipath-tcp/mptcp_net-next/issues/466
>>>=20
>>> and WFM. @Christoph could you please validate this in your testbed, =
too?
>>=20
>> Yes, this fixes both #466 and #465.
>>=20
>> I=E2=80=99m updating syzkaller and if it=E2=80=99s happy I can push =
it to upstream.
>=20
> Thanks for testing and doing the process!
>=20
> I'm wondering if there are other pending issues that impact your
> deployment someway?

Right now, nothing. RHEL 9.3 is running well ;-)


Christoph

>=20
> Cheers,
>=20
> Paolo
>=20

