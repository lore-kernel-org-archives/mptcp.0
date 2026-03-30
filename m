Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022D937EFEE
	for <mptcp@lists.linux.dev>; Mon, 30 Mar 2026 08:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774858758; cv=none; b=iYwNAATJiADqUhW5/XvY37hzuvu3c+fU/lVGCOlGcgIB/ym3D2OrVDJo64DIiGFO/7HYBCFgfrUQv+hgrPq2C0wnOyW4cY34Hn/nf3KONS1bMAqDIxGFtULfavc6pIWZAFtfi7GzugVhKpuOkS2ODtJ+YuZt4xxMM58XfQ/TnQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774858758; c=relaxed/simple;
	bh=5LiH2PMLXnbW30gSarjbOl4YJEP5Cj3aQcJnWiHJA7U=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:
	 In-Reply-To:References; b=NAcJSVBs7znYQTV+UxujVCULidxikel5L1hxh9JuRVvDfc7Djww5ioHagb1mn1JBBUVcRbjxhe75rwRZuHbAQfI40bBxZ+QI2q4f+tMxfX++0mW93GXKV4MBRg+mnu4pV9OoDA4cTXBey0AwY2sirs+jYLWCZiR9QehgLtAmhqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xqs0otmH; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xqs0otmH"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774858755;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oo1yfvqB54IzdHY3lL9WfHVPn1z/EXQWKB1IAmfSe0o=;
	b=xqs0otmH7+8MdlgtE0cigBIRSGNPFGtDYRkKbTAiNYburcQ7JVtxyxHZudTV2JLT3ODb+G
	A20I9ku8RdxMZlgOtA2GBPWA+CfIaCnTq+HiqUEBSoCFpkqMG8hV94+qxrmDswJYIwU7gN
	InzS0stjTTapxkRrKc3raFw8cUSo13A=
Date: Mon, 30 Mar 2026 08:19:13 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: gang.yan@linux.dev
Message-ID: <be87d58dcca25715b3f992acd152a6778de44dec@linux.dev>
TLS-Required: No
Subject: Re: [PATCH mptcp-next] mptcp: preserve MSG_EOR semantics in sendmsg
 path
To: "Matthieu Baerts" <matttbe@kernel.org>, mptcp@lists.linux.dev
In-Reply-To: <c572547f-449b-43e9-bd76-e0ffe2ebf735@kernel.org>
References: <20260309025431.125943-1-gang.yan@linux.dev>
 <c572547f-449b-43e9-bd76-e0ffe2ebf735@kernel.org>
X-Migadu-Flow: FLOW_OUT

March 27, 2026 at 12:42 AM, "Matthieu Baerts" <matttbe@kernel.org mailto:=
matttbe@kernel.org?to=3D%22Matthieu%20Baerts%22%20%3Cmatttbe%40kernel.org=
%3E > wrote:


>=20
>=20Hi Gang,
>=20
>=20Thank you for the new version.
>=20
>=20On 09/03/2026 03:54, Gang Yan wrote:
>=20
>=20>=20
>=20> From: Gang Yan <yangang@kylinos.cn>
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
>=20Please mention why you shrank "overhead" to a u8 (not to increase the
> struct size), and why it is OK to do so (u16 not needed because ...) +
> explaining the BUILD_BUG_ON().

The =E2=80=98u8=E2=80=99 is one of Paolo's suggestions[1]. I think 'u16' =
is not needed because:
 - 'offset =3D ALIGN(orig_offset, sizeof(long));'
 - 'dfrag->offset =3D offset - origin_offset + sizeof(struct mptcp_data_f=
rag);',
the max value of offset is 7, and sizeof(struct mptcp_data_frag)) is
usually 40, so the overhead is 47, far less than 255.

Another suggestion from Paolo[1] is a build time check on the max 'overhe=
ad'
value. So I use 'ALIGN(1, sizeof(long)) + sizeof(struct mptcp_data_frag)'=
 to
represent the max_val of 'overhead'.

But Paolo also mention it's probably too conservative. WDYT?

[1] https://patchwork.kernel.org/project/mptcp/patch/20260203023029.85543=
4-1-gang.yan@linux.dev/

>=20
>=20>=20
>=20> - Packetdrill test cases validating this feature are available at:
> >  https://github.com/multipath-tcp/packetdrill/pull/189/changes/d6ce92=
a4786704fe749bbd848ced0c047632282e
> >=20
>=20Thank you, I just reviewed it.

Thanks=EF=BC=8C I'll try to fix them.

>=20
>=20Do you mind checking the AI review there please:
>=20
>=20https://netdev-ai.bots.linux.dev/ai-review.html?id=3D22434689-7326-48=
c8-af75-273d99fbef55
>=20
>=20I think it is valid, but better to double-check.

Yes, I think it's a good catch, and we should fix it as follows:

@@ -1032,7 +1032,8 @@ static bool mptcp_frag_can_collapse_to(const struct=
 mptcp_sock *msk,
                                       const struct page_frag *pfrag,
                                       const struct mptcp_data_frag *df)
 {
-       return df && pfrag->page =3D=3D df->page &&
+       return df && !df->eor &&
+               pfrag->page =3D=3D df->page &&
                pfrag->size - pfrag->offset > 0 &&
                pfrag->offset =3D=3D (df->offset + df->data_len) &&
                df->data_seq + df->data_len =3D=3D msk->write_seq;
If OK, I'll apply it when sending v2.

>=20
>=20>=20
>=20> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> >  index 17e43aff4459..3e574c87301b 100644
> >  --- a/net/mptcp/protocol.c
> >  +++ b/net/mptcp/protocol.c
> >=20
>=20(...)
>=20
>=20>=20
>=20> @@ -4621,6 +4638,9 @@ void __init mptcp_proto_init(void)
> >  inet_register_protosw(&mptcp_protosw);
> >=20=20
>=20>  BUILD_BUG_ON(sizeof(struct mptcp_skb_cb) > sizeof_field(struct sk_=
buff, cb));
> >  + /* Compile-time check: ensure 'overhead' (alignment + struct size)=
 fits in u8 */
> >  + BUILD_BUG_ON(ALIGN(1, sizeof(long)) + sizeof(struct mptcp_data_fra=
g) > U8_MAX);
> >=20
>=20Sorry, I'm not sure what you are checking here. Do you mind explainin=
g
> it please?
>=20

The=20'BUILD_BUG_ON' is explained at the beginning of the reply, thanks.

Cheers,
Gang

> Cheers,
> Matt
> --=20
>=20Sponsored by the NGI0 Core fund.
>
