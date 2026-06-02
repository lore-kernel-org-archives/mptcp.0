Received: from outbound.qs.icloud.com (qs-2002a-snip4-4.eps.apple.com [57.103.87.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC0631F9A3
	for <mptcp@lists.linux.dev>; Tue,  2 Jun 2026 03:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.87.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780371847; cv=none; b=gptJY3D3b70K7n0RGBMsfrOg6pYe626YZPVOoE9MXXxM1C4tS0BXkpeZOuKIubcCvZsqq79G3KomgMZCXPxZ2rn/fcI4boEx5n+V0GVU4vN84jsBScbu/FLPrTthNkcqDes4544OSxIhU36t93Hrpnf6pcEBKP1gpxswC8JJLyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780371847; c=relaxed/simple;
	bh=wm/G5Eaq+6MAI8W4S8wjmjkpllI00PTImgvvIudJ9sE=;
	h=Content-Type:From:Mime-Version:Date:Message-Id:Cc:To; b=pijqa7/0J/ng1idugFRe7FhgdvFv4dBKoIYXPh/addCDqsdirjk7gFqmnt8EXvPOxUKT3vVlF9XWIqiRGVp8WGS2b+aWQo77lIGOxYXjV3HcQxERsskP/gAiZZXsj+YeMhiJCRD3bBynMxqNd04ryrQbSodaX5Wgmp1ySz4ftt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=jxVybDJN; arc=none smtp.client-ip=57.103.87.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="jxVybDJN"
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-2d-60-percent-2 (Postfix) with ESMTPS id 65BD81800224;
	Tue, 02 Jun 2026 03:44:04 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQhACkMFWwFeCEgFQwZeAFBcHA4KUgpAGF4NVh9FDkAfeRFQAVgeVl5aF15NUQ8PGVoUXBhTRVEfVFhBDgpYEhhcFFxQWB5GElYNXQkZGkFeUBtfAkIPHBNWFRMdQxkPKwhKBEMHRQJeCyUTCVNWWxNVF0YJGQhdHRkVWgkKVwJBCkh3WQcpH0kNSQRAA1gHRRRAcCsBRgtFDD0BXgBZdkB6TXMEVAddBV1WUAJaVRIEQAhWUF4IXh9MHA==
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1780371845; x=1782963845; bh=wm/G5Eaq+6MAI8W4S8wjmjkpllI00PTImgvvIudJ9sE=; h=Content-Type:From:Mime-Version:Date:Message-Id:To:x-icloud-hme; b=jxVybDJNxZFTIP3nFLqIIvGUOl6r3G3RkMwy1Nnw8+oPczxz79jQ3MOlhmoGCENb8MwHeKrPGAkudY+MTQxwqoFFceY4mpOyYsQv0xwAYLYzAxloOUUOWTd5lsoqW/kadFwQYJdzqbcj1gwAXQ2nrEXLmwDP28BT7fTxg33xDL/ldgyUvTxalBo6ZzVJINGEugMqx6pCFVbsSueFzQQdkJGV7zT9QpNnBkOS5V21EGhqAztaI7RJ96vcleFGrlozm1RH+u0hy1Hu2zOmycJwPd9Se22qxKI1B6OCh179+iQWwRvJbYeRqDhRrn4jc+JpP+D+n4UGuwKC5QZF6K1p7Q==
mail-alias-created-date: 1755741129474
Received: from smtpclient.apple (unknown [17.57.155.37])
	by p00-icloudmta-asmtp-us-east-2d-60-percent-2 (Postfix) with ESMTPSA id 7B5271800109;
	Tue, 02 Jun 2026 03:44:03 +0000 (UTC)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Chris Guerrero <gearhguerrero@icloud.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (1.0)
Date: Mon, 1 Jun 2026 21:44:00 -0600
Message-Id: <0130D40B-9417-4355-8CF6-955E2372D0C5@icloud.com>
Cc: mptcp@lists.linux.dev, Eric Dumazet <edumazet@google.com>
To: Matthieu Baerts <matttbe@kernel.org>
X-Mailer: iPhone Mail (23F77)
X-Proofpoint-GUID: JCpe9DgNO_LR1nvzHk9fjYBlefeD16R7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDAzMCBTYWx0ZWRfX77aYL4kl3o7u
 KKdaBczQjP5W2jnP4li4kHlDMhjT0zxiXnFTaXGLz/Ty3Gmt0Etnsis9Udr8TiORWVZ9bhX8pEK
 ZR/rkfCODxuugeSd/2cLWPI7uwLWeSifkhEsRfZbPk/Jh3IMeD6SYj8b/hCyWcs/kAxeC2/1Rj5
 sjWyKXwcpYXhrxsJm+QKW+ovQXUfxIAeMTYMM1vbhTgTQcBeVuPyIHItwnb3+A4yZjka4RSdy0E
 IEtF9MQ76i/qBvwH5sihO5aJ0lfjT0G0PHMunfC7SFkrl/nS27AOn12qp90ZodlyzD4Qi9Tlja7
 IEad8dx1D2JfuKFsaIV2mzgYuX/o01OifFs2FSPR5nGl3k+gKWRhYnFQn2DYE4=
X-Authority-Info-Out: v=2.4 cv=MOdtWcZl c=1 sm=1 tr=0 ts=6a1e5184
 cx=c_apl:c_pps:t_out a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=s5jvgZ67dGcA:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=x7bEGLp0ZPQA:10 a=8IWW5uUoFxMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=HpEtpkEjWIJ7oRqy2ysA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-ORIG-GUID: JCpe9DgNO_LR1nvzHk9fjYBlefeD16R7


> On Jun 1, 2026, at 5:22=E2=80=AFAM, Matthieu Baerts <matttbe@kernel.org> w=
rote:
>=20
> =EF=BB=BFHello,
>=20
> 01 Jun 2026 21:13:02 MPTCP CI <wpasupplicant.patchew@gmail.com>:
>=20
>> - KVM Validation: normal (except selftest_mptcp_join): Unstable: 1 failed=
 test(s): packetdrill_add_addr =E2=9A=A0=EF=B8=8F
>=20
> FYI, this failed test is expected: the patch has been applied on an
> older base to avoid conflicts, and these tests depend on new features.
>=20
> Cheers,
> Matt
>=20
