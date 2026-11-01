Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793518074;
	b=hsIXZFp2wetG9ADjn18zhFDLSDlm1daJIRXWwzv2Mn3tPZYfDDiBsNFH/r9SwK8Puprg
	 Ps7IQFB/G3vSDFtXgzDRSNTFHtGRqYrAG/Y/TlyVjhY29tOMVujqk8KKaTgefGJT3UElk
	 BNhoWO/LHP8PykM1LlmRWH7z4VfY0ES0zJWr3D1oOi3zdveBMhAh++6QUE4py05lvY59g
	 vDP4gOiD6IjwRdIuJzFCRjrC2hQPZTp9hzCCBXLLvTUb2WPiDhMPVXbeRaYi4lN7m7GJI
	 y1p6/GpSXB4wVe1K0tFoqNR+XD+1IuBzA0L6UmXCbeiG6l6C1DAF56gbIjyShrXssgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793518074;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=/SXMls89LLO+dumq7w3nZPW8qZruBZpzMJrboyDg0Kg=;
	b=VFUYmvHLyrnWExZCb1k2Aoe3q/xBd4M/xwY2a3Js8pq31xlsjrRSLeBsznuPRDP3xaya
	 5TUZljzcd31mCSAls6iSfdubb/6mJadyFziIKKxXn0CwxacE/vFapkQkJKfLkue7l16ML
	 nRHOamr0AxUcMY8AXtg0iEsPAkvHB7YrFw+UHxA1OutcEO+BTgmOChADt/FvFOsGdYvHO
	 4Jt0xcgSWCfGLTDgjHD2IwNlwfsTTZVB1KugopS87TvZ9K20ZN6TS6QpikaxbFDJb1gmB
	 2L9KQhLw4vHkw8QvxV1gDS3xWr7XM0qMXebJ90uZVN1p2ClRyiMrJX+Nz8z36yeb6hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N+ct7WvE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79EDD606A324
	for <mptcp@lists.linux.dev>; Sun,  1 Nov 2026 07:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N+ct7WvE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BCB21F000C1;
	Sun,  1 Nov 2026 07:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793518074;
	bh=/SXMls89LLO+dumq7w3nZPW8qZruBZpzMJrboyDg0Kg=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=N+ct7WvEPUrSTTY08SCrCoue3QuGbYc7LvrwGK+tGt7npHG7QDCbYaAXtpxH8xFIX
	 UuzrSwTW8dhkYSi/dZASxij/KT88n8/ubYm4nY+ZvEB06Mz/srhgONXggFV8Iv631F
	 kNNNY9pJXFCrf2VwCXxde6P/JSwQMjZVYCEAMZJJyYpGBSIhr2wmPgvqb2QHV2h+sB
	 hWICbwYgyKAFtED4v42WvLVHJ7VT31zT0cA0NmxPmEuIjmYKPhvhIs71T0zCFQPPKe
	 27Lv1Ud2FMi97aI2T9acWFzcKzKhzlPEkwEn2Q1lKKi5VhUP0EikTac1DEq0IiM9AH
	 oQRqUSjyaKGHQ==
Message-ID: <sashiko-outbox-192308@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v14 3/6] mptcp: pm: in-kernel: add the
 subflow-retries limit
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anil Kaushik" <anilkaushikwireless@gmail.com>, mptcp@lists.linux.dev
In-Reply-To: <20261101072051.3853492-4-anilkaushikwireless@gmail.com>
References: <20261101072051.3853492-1-anilkaushikwireless@gmail.com>
 <20261101072051.3853492-4-anilkaushikwireless@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 01 Nov 2026 07:27:53 +0000
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] mptcp: pm: mixed limit validation in mptcp_pm_nl_set_limits_doit()
--

commit a548b0ce8ac5f215ffb57499482e189af72f45ad
Author: Anil Kaushik <anilkaushikwireless@gmail.com>

mptcp: pm: in-kernel: add the subflow-retries limit

This commit adds a new subflow-retries limit to the in-kernel path manager
for configuring the number of SYN retries when re-creating a subflow after
a timeout, and exposes it in struct mptcp_info.

> diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
> index d3014bf57bf3c..7fb4c78743409 100644
> --- a/net/mptcp/pm_kernel.c
> +++ b/net/mptcp/pm_kernel.c

[ ... ]

> @@ -1419,7 +1428,8 @@ static int parse_limit(struct genl_info *info, int =
id, unsigned int *limit)
>  int mptcp_pm_nl_set_limits_doit(struct sk_buff *skb, struct genl_info *i=
nfo)
>  {
>  	struct pm_nl_pernet *pernet =3D genl_info_pm_nl(info);
> -	unsigned int rcv_addrs, subflows;
> +	unsigned int rcv_addrs, subflows, retries;
> +	struct nlattr *attr;
>  	int ret;
> =20
>  	spin_lock_bh(&pernet->lock);
> @@ -1433,8 +1443,13 @@ int mptcp_pm_nl_set_limits_doit(struct sk_buff *sk=
b, struct genl_info *info)
>  	if (ret)
>  		goto unlock;
> =20
> +	/* the maximum, MAX_TCP_SYNCNT, is checked by the policy */
> +	attr =3D info->attrs[MPTCP_PM_ATTR_SUBFLOW_RETRIES];
> +	retries =3D nla_get_u32_default(attr, pernet->limit_subflow_retries);

[Severity: Low]
As reported by Matthieu Baerts on v7 [1], mptcp_pm_nl_set_limits_doit() in
net/mptcp/pm_kernel.c now mixes two different limit validation approaches:
MPTCP_PM_ATTR_RCV_ADD_ADDRS and MPTCP_PM_ATTR_SUBFLOWS are checked via
parse_limit(), while MPTCP_PM_ATTR_SUBFLOW_RETRIES relies on the netlink
policy and nla_get_u32_default().

Should a prerequisite patch convert the existing two limits to use netlink
policy validation and nla_get_u32_default() as well (or should this new
limit continue using parse_limit()) so all limits in
mptcp_pm_nl_set_limits_doit() are handled uniformly?

[1] https://lore.kernel.org/r/56679372-0ae6-43bf-b0fa-a6b853a1b68c@kernel.o=
rg

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261101072051.3853=
492-1-anilkaushikwireless@gmail.com?part=3D3
