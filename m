Received: from mta1.migadu.com (out-216.mta1.migadu.com [95.215.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47C71A9B24
	for <mptcp@lists.linux.dev>; Fri, 14 Aug 2026 03:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786676546; cv=none; b=Q7suWKo+7ViK3nIzx7vG3jC5VjNOGlvKE88RSECwNQoFG4zG6tKuvH8PmX198ZaKhYaL4FILFb/7hH7WtLQ8uacj6do8txL9fJSRo26NYcSeypUJU11xop2qiyOWeS8EXNeeQiG8M7QGMbQzl8OseKCeYxeTPw2IX4cRFhvIGfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786676546; c=relaxed/simple;
	bh=f5sZGFFv2NWqExHF887sPqI07rG9Sz2t1paDnl8nuWw=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=mFRmuV/Mu1w7cv9KWvhp98YMT5jsJDqTHw9YJVHB6nffDFYqwKlKksCz8Dd+Xpx7S4jaYeJX1SBvfUlrjyh6M3klgmuQcP5DKPjOFPL4KSJQrUwHlG9/b7789XDV6lozS30n0890YFFzxmaqvBgaK2GGk43R4P1NaNOYtoPqzrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QPa87MV6; arc=none smtp.client-ip=95.215.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QPa87MV6"
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=f5sZGFFv2NWqExHF887sPqI07rG9Sz2t1paDnl8nuWw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786676541; v=1; x=1787281341;
 b=QPa87MV66oEVPXh4frvYIrzGiCYI5iRR4blh094pkFkYOYdktFR6TVgh8mGWQKy6xnyTKLKK
 NssmkCqDI4vJjQUWICFHp/1OYyippwa1IzIV732GM9x4BYxXAw6aZyDGtvfSC7UHJOr1rCeW8c9
 A/+xOvJnaRG7hJQanN0JpGG0=
X-Envelope-To: mptcp@lists.linux.dev
Received: from webmail.migadu.com (2001:41d0:303:fc7a::)
	by mta12.migadu.com with ESMTPS id a3ea009933ca1d90;
	Fri, 14 Aug 2026 03:02:21 +0000
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Fri, 14 Aug 2026 03:02:21 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: gang.yan@linux.dev
Message-ID: <3c9241d11965180046042f4c6079ebb1e38b54dd@linux.dev>
TLS-Required: No
Subject: Re: [PATCH export v3 2/4] mptcp: reject joins after fallback in
 mptcp_is_fully_established
To: "Matthieu Baerts" <matttbe@kernel.org>, "Paolo Abeni"
 <pabeni@redhat.com>, "Chenguang Zhao" <chenguang.zhao@linux.dev>,
 mptcp@lists.linux.dev
Cc: "Chenguang Zhao" <zhaochenguang@kylinos.cn>
In-Reply-To: <db6bd87f-f7cd-4b02-a471-db549cbca384@kernel.org>
References: <20260812054653.43799-1-chenguang.zhao@linux.dev>
 <20260812054653.43799-3-chenguang.zhao@linux.dev>
 <1d7c56b9-00c1-4550-a403-c3d704259267@redhat.com>
 <41078a8c-00c7-4cb1-8e57-237b4ea6c2f0@kernel.org>
 <564cb027be5e7972fc8f6f976707628ee32f38aa@linux.dev>
 <db6bd87f-f7cd-4b02-a471-db549cbca384@kernel.org>

August 14, 2026 at 1:42 AM, "Matthieu Baerts" <matttbe@kernel.org mailto:=
matttbe@kernel.org?to=3D%22Matthieu%20Baerts%22%20%3Cmatttbe%40kernel.org=
%3E > wrote:
>=20
>=20In addition, in the case we are trying to fix here, the MP_FAIL is
> received before switching to fully established: the RFC doesn't explain
> this particular case, but it sounds like there is no need to send the
> infinite mapping, and a fallback can be done directly *I think*. The
> thing is this situation shouldn't happen: we are not supposed to receiv=
e
> an MP_FAIL at that stage, no data has been exchanged at the MPTCP level=
,
> so let's do the minimal -- i.e. just a fallback -- to avoid issues and
> reduce the complexity, no?
>=20

Hi=20Matt,=20

Thanks=20for your explanation. I have a quick thought:

Can we check the 'subflow->send_mp_fail' in 'subflow_finish_connect'? lik=
e:

'''
...
 543         if (subflow->request_mptcp) {
 544                 if (!(mp_opt.suboptions & OPTION_MPTCP_MPC_SYNACK)) =
{
 545                         if (!mptcp_try_fallback(sk,
 546                                                 MPTCP_MIB_MPCAPABLEA=
CTIVEFALLBACK)) {
 547                                 MPTCP_INC_STATS(sock_net(sk),
 548                                                 MPTCP_MIB_FALLBACKFA=
ILED);
 549                                 goto do_reset;
 550                         }
 551=20
=20552                         goto fallback;
 553                 }
             if (subflow->send_mp_fail)
                             goto fallback;
 554=20
...
'''

Or,=20check msk->fully_established in pm_fail_received like this:
'''
@@ -901,6 +898,12 @@  void mptcp_pm_mp_fail_received(struct sock *sk, u64=
 fail_seq)
 		subflow->send_mp_fail =3D 1;
 		subflow->send_infinite_map =3D 1;
 		tcp_send_ack(sk);
+
+		if (!msk->fully_established && !mptcp_try_fallback(sk, MPTCP_MIB_MPFAI=
LFALLBACK)) {
+			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_FALLBACKFAILED);
+			mptcp_subflow_reset(sk);
+		}
'''=20

Because=20the MP_FAIL specified in the RFC does not seem to actively trig=
ger a fallback
on its own; instead, it is triggered via the infinite mapping. If we modi=
fy the
behavior of MP_FAIL in the regular path, I think it might be over-design =
and could
introduce additional risks. What do you think?

Thanks
Gang

> Cheers,
> Matt
> --=20
>=20Sponsored by the NGI0 Core fund.
>
