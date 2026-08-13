Received: from mta1.migadu.com (out-65.mta1.migadu.com [95.215.58.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E7C30F924
	for <mptcp@lists.linux.dev>; Thu, 13 Aug 2026 09:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786613578; cv=none; b=dAGr2Dv7kYhizwM+IbVGG3DiVfAV0j4cdMmvt/cY9IO0FmLiYDvj61zV9TD3zl55K7L5AKRmKihqV08Mgl479YfoU2HOfsILP8CR0927JXQhd7eSoGqeQsFWQb4hs9604PmvYDq8mONJWLD9t0wP0ZzMb0rQYy61+cnGJHIxYz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786613578; c=relaxed/simple;
	bh=DmleVpQVLeTu43U8q5DTVCb0bGggiFx707RffKIEaLc=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=RnGaALvTvzgWHGQKoFVCLVzRd3lUp+H8WY1c1M0VQj8wsXvPv1ufZFDvo+Hf/otJiL5Lbt5lCrg6QODNKYNtAcJPfOIcXKzgnipncBI7azM90yC4aMLPjY+dBzloBnJZQK62s/tLKXHkULo/llEcj0kD2Q4mY05UYrhe+7uLrCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Gl2Uwx+U; arc=none smtp.client-ip=95.215.58.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Gl2Uwx+U"
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=DmleVpQVLeTu43U8q5DTVCb0bGggiFx707RffKIEaLc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786613573; v=1; x=1787218373;
 b=Gl2Uwx+Uo6v5Mq0fQ05vxN6fZW8IBXdS6H2GCAD4k6ZpGNX3mjtznYedIRKyyon3EhDiEfKM
 9Gb40pVKSwYJYRyZp/AX+zje71zUSW9OJtCd9x58KNSDuJ5lT8ujSTNbcurzUhJI4j7BPcQwJh2
 ONPnV7+E11hsS3XleuQ8/Lfk=
X-Envelope-To: mptcp@lists.linux.dev
Received: from webmail.migadu.com (2001:41d0:303:fc7a::)
	by mta12.migadu.com with ESMTPS id cef5bd278c7ffc0f;
	Thu, 13 Aug 2026 09:32:53 +0000
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Thu, 13 Aug 2026 09:32:53 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: gang.yan@linux.dev
Message-ID: <564cb027be5e7972fc8f6f976707628ee32f38aa@linux.dev>
TLS-Required: No
Subject: Re: [PATCH export v3 2/4] mptcp: reject joins after fallback in
 mptcp_is_fully_established
To: "Matthieu Baerts" <matttbe@kernel.org>, "Paolo Abeni"
 <pabeni@redhat.com>, "Chenguang Zhao" <chenguang.zhao@linux.dev>,
 mptcp@lists.linux.dev
Cc: "Chenguang Zhao" <zhaochenguang@kylinos.cn>
In-Reply-To: <41078a8c-00c7-4cb1-8e57-237b4ea6c2f0@kernel.org>
References: <20260812054653.43799-1-chenguang.zhao@linux.dev>
 <20260812054653.43799-3-chenguang.zhao@linux.dev>
 <1d7c56b9-00c1-4550-a403-c3d704259267@redhat.com>
 <41078a8c-00c7-4cb1-8e57-237b4ea6c2f0@kernel.org>

August 12, 2026 at 11:32 PM, "Matthieu Baerts" <matttbe@kernel.org mailto=
:matttbe@kernel.org?to=3D%22Matthieu%20Baerts%22%20%3Cmatttbe%40kernel.or=
g%3E > wrote:


>=20
>=20Note: Chenguang is looking at a bug where, when an MP_FAIL is receive=
d
> before being in fully_established, the kernel accept going to fully
> established, and creating new subflows, then reject them once done.
>=20
>=20Same when receiving a 4th packet without MPTCP options.
>=20
>=20I think the MP_FAIL should do a fallback if possible, but it is proba=
bly
> also required to check the fallback status or something similar when
> receiving an MPJ.

Hi, Matt

Sorry, I'm not very familiar with the details of this patch.

No offense intended, I just have a question I'd like to ask based on my
understanding and the RFC documentation: Should MP_FAIL trigger a fallbac=
k?

For the multiple=E2=80=91subflow case, if one subflow encounters an MP_FA=
IL, it should
be closed with a RST, and the data will be retransmitted over the other h=
ealthy
subflows. This should not cause the entire MPTCP connection to fallback t=
o regular
TCP, right?
RFC8684's contents:
'''
The receiver of this option MUST discard all data following the data sequ=
ence number
specified. Failed data MUST NOT be DATA_ACKed and so will be retransmitte=
d on other subflows.
'''


For the single=E2=80=91subflow case, according to the RFC, MP_FAIL should=
 subsequently
lead to a fallback under the infinite mapping (INFINITEMAP) situation, sh=
ouldn't it?
RFC 8684's contents:
'''
A special case is when there is a single subflow and it fails with a chec=
ksum error.
If it is known that all unacknowledged data in flight is contiguous (whic=
h will usually
be the case with a single subflow), an infinite mapping can be applied to=
 the subflow
without the need to close it first, essentially turning off all further M=
PTCP signaling.
'''

Thanks
Gang


>=20
>=20>=20
>=20> I would prefer avoiding additional conditionals, if not well reason=
ed.
> >=20
>=20Agreed, the commit messages in this series are not explaining (enough=
)
> the reason and the context.
>=20
>=20BTW, Chenguang, please use 'mptcp-net' for fixes (and mptcp-next for
> features). Also fixes should have a Fixes tag.
>=20
>=20Cheers,
> Matt
> --=20
>=20Sponsored by the NGI0 Core fund.
>
