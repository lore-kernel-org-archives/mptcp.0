Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1BA37C92E
	for <mptcp@lists.linux.dev>; Tue, 31 Mar 2026 06:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774940104; cv=none; b=eP49EQx+RwxaKygD9yj3hb94fPqpqqI1tyMinxLl0H0X4lU74gEiGdvsNUE+VpOfTdA/gzeN4Qq5FVeJ7cVgLYDgS6j7Kp0tB4GKHk/SgKk0tdQBwVeY6fBzPRKPN9ll/G2lAApRmZBK09YR5C9waYmqYIBYmJruz921xfwACKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774940104; c=relaxed/simple;
	bh=2yMFKjyCIxPlIAiaae/dh9NVo4dyuCLIYWJSYqWGUlU=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:
	 In-Reply-To:References; b=St4RkOBWFsvSaz/ud3DMcyxBlLW7Kb0SoxVdHFTROaayKmD/Z5VbQFqN5qM2uTkaZ9XxVV17RXMzmPVGMvTfVNCfE4IGhyt37VA2qLOkXwgtoCRh3SbFZE7NadTTB9DTB2yYyFiGtQZuvUxVYZRmkAL0l8nNF+bqHXVGyFIl4Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KZlfhOrR; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KZlfhOrR"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774940100;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ssNIrGA51ibt7TKqlacnJQAy4JwFn4K7csbhFC6aHcM=;
	b=KZlfhOrRpH7f88lXzA6ArnMiwyKsjzCfD7r+/T7FXys1wY/xohUo1nPNBPxB/Gdh/b2/5P
	tbiCnz41euVSC5fusfgy4N0FLms2yBzfXAlzaqym0+4bK1mFX3rIOHxdaEYCunMKp6G1wH
	kriGxE8mZzYqowM9Vca13erJFXLzz0M=
Date: Tue, 31 Mar 2026 06:54:58 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: gang.yan@linux.dev
Message-ID: <4e5dee5ddbad71843a3ff2cb463690324df18acf@linux.dev>
TLS-Required: No
Subject: Re: [PATCH mptcp-next] mptcp: preserve MSG_EOR semantics in sendmsg
 path
To: "Matthieu Baerts" <matttbe@kernel.org>, mptcp@lists.linux.dev
In-Reply-To: <8eb9b926-9402-41e7-9574-f2886f67d14e@kernel.org>
References: <20260309025431.125943-1-gang.yan@linux.dev>
 <c572547f-449b-43e9-bd76-e0ffe2ebf735@kernel.org>
 <be87d58dcca25715b3f992acd152a6778de44dec@linux.dev>
 <8eb9b926-9402-41e7-9574-f2886f67d14e@kernel.org>
X-Migadu-Flow: FLOW_OUT

March 30, 2026 at 5:50 PM, "Matthieu Baerts" <matttbe@kernel.org mailto:m=
atttbe@kernel.org?to=3D%22Matthieu%20Baerts%22%20%3Cmatttbe%40kernel.org%=
3E > wrote:


>=20
>=20Hi Gang,
>=20
>=20On 30/03/2026 10:19, gang.yan@linux.dev wrote:
>=20
>=20>=20
>=20> March 27, 2026 at 12:42 AM, "Matthieu Baerts" <matttbe@kernel.org m=
ailto:matttbe@kernel.org?to=3D%22Matthieu%20Baerts%22%20%3Cmatttbe%40kern=
el.org%3E > wrote:
> >=20=20
>=20>=20=20
>=20>=20
>=20> >=20
>=20> > Hi Gang,
> > >=20
>=20> >  Thank you for the new version.
> > >=20
>=20> >  On 09/03/2026 03:54, Gang Yan wrote:
> > >=20
>=20>  From: Gang Yan <yangang@kylinos.cn>
> >=20=20
>=20>  Extend MPTCP's sendmsg handling to recognize and honor the MSG_EOR=
 flag,
> >  which marks the end of a record for application-level message bounda=
ries.
> >=20=20
>=20>  Data fragments tagged with MSG_EOR are explicitly marked in the
> >  mptcp_data_frag structure and skb context to prevent unintended
> >  coalescing with subsequent data chunks. This ensures the intent of
> >  applications using MSG_EOR is preserved across MPTCP subflows,
> >  maintaining consistent message segmentation behavior.
> >=20=20
>=20>  Signed-off-by: Gang Yan <yangang@kylinos.cn>
> >  ---
> >=20=20
>=20>  Notes:
> >  - This patch incorporates feedback and suggestions from Paolo Abeni
> >  and Geliang Tang, including memory alignment optimizations for the
> >  mptcp_data_frag struct (shrinking overhead to u8 and using bitfield
> >  for eor to avoid size increase) and compile-time checks with BUILD_B=
UG_ON.
> >=20
>=20> >=20
>=20> > Please mention why you shrank "overhead" to a u8 (not to increase=
 the
> > >  struct size), and why it is OK to do so (u16 not needed because ..=
.) +
> > >  explaining the BUILD_BUG_ON().
> > >=20
>=20>=20=20
>=20>  The =E2=80=98u8=E2=80=99 is one of Paolo's suggestions[1]. I think=
 'u16' is not needed because:
> >  - 'offset =3D ALIGN(orig_offset, sizeof(long));'
> >  - 'dfrag->offset =3D offset - origin_offset + sizeof(struct mptcp_da=
ta_frag);',
> >  the max value of offset is 7, and sizeof(struct mptcp_data_frag)) is
> >  usually 40, so the overhead is 47, far less than 255.
> >=20
>=20Thank you for the explanation. Can you then mention in the commit
> message that it is fine to reduce overhead to a 'u8', and add the above
> explanation, please?
>=20
>=20If 'offset' max value is 7, it could also be reduced from a u16 to a =
u8
> then, no?

Hi, Matt:

Sorry, there was an error in the explanation. The maximum value of
(offset - origin_offset) is 7, so the 'offset' variable should use u16.

>=20
>=20>=20
>=20> Another suggestion from Paolo[1] is a build time check on the max '=
overhead'
> >  value. So I use 'ALIGN(1, sizeof(long)) + sizeof(struct mptcp_data_f=
rag)' to
> >  represent the max_val of 'overhead'.
> >=20
>=20It might be good to add a comment here too, at least to explain that
> "ALIGN(1, sizeof(long))" represents 'offset' maximum size.

Good idea, I'll apply your suggestions in v2.

Thanks
Gang
>=20
>=20>=20
>=20> But Paolo also mention it's probably too conservative. WDYT?
> >=20
>=20Maybe, but it doesn't hurt I suppose. As long as this check is clearl=
y
> linked to different fields from the mptcp_data_frag structure =E2=86=92=
 having a
> comment explaining that.
>=20
>=20Cheers,
> Matt
> --=20
>=20Sponsored by the NGI0 Core fund.
>
