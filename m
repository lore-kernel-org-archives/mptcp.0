Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1060214C5AF
	for <mptcp@lists.linux.dev>; Tue, 17 Dec 2024 06:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734417451; cv=none; b=thTX2HCascjndcEsUBxGRCJ8N1WfbU5fS/4d8+qPFFHQ3zdoXxfOTWC4+6rE4zJ046+pLJ1wEnDO9Gwa4B32Q/gEcuIuKIa+6S6oxDNZejHBaoeFpt8EV8Qx3WDTiC/f8HLxhHZOt2fH8lJ6g5naoqAQDw2TgHnbzNh/0S0ezFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734417451; c=relaxed/simple;
	bh=lF65tprIYtl2IDGuum0Hleabv1KIb6uIPru7G//KOsU=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NfZaES75tq9qp0yvzkais6MznpwmnrZ+X9m7Qt5PeZkWu9AYxyiEe2rmrv9oqpe/Gw9xLO4BoNB7b5mF3r24tTy0Gl52kEUU8SIhlofVbbBNtKwk8IS4/ZhwfxU03alfVPmj06HCmtdE93/k0Nu19RMSU/fcRAeJKZ2j7hiv8II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=khTCfQ9O; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="khTCfQ9O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB17AC4CED3;
	Tue, 17 Dec 2024 06:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734417450;
	bh=lF65tprIYtl2IDGuum0Hleabv1KIb6uIPru7G//KOsU=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=khTCfQ9O7eZhv4cTNIxy5i2PdoFFUMEUzSipUTb+SKx55oW6LaBp1wqjg7cz3lL5s
	 sxxYAbC6uQUx1h25csD2WUD63Mxlp5ME3KNqTEsSlclkBpG/uH+Lyk6h5xIS9gMk93
	 oKz94+j70Ib6jG5w8JlNCrtucnhu8VRmUMjiF5swzdoUkJOnWBO1MyAG692+EToEiv
	 iVvaB1tUtDXkCsGnzrONW/q2c+rEKSARV+gVrjqHdm4t/uJrNIFw6Rfz/Q6IV0WTeJ
	 jQ7KhyCxr+uIcoAxHOULpLsYlJrLskP60iRDvUayS893Vn65PD3SnSkuf5tZtVfF/l
	 k2pKy0C46OUOQ==
Message-ID: <08c74ee545c76173c523a5839c4e714ba29c40b5.camel@kernel.org>
Subject: Re: [PATCH mptcp-net v2 3/3] netlink: specs: mptcp: fix missing doc
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, mptcp@lists.linux.dev
Date: Tue, 17 Dec 2024 14:37:27 +0800
In-Reply-To: <20241216-mptcp-pm-nl-spec-doc-attr-v2-3-68807f55d42c@kernel.org>
References: 
	<20241216-mptcp-pm-nl-spec-doc-attr-v2-0-68807f55d42c@kernel.org>
	 <20241216-mptcp-pm-nl-spec-doc-attr-v2-3-68807f55d42c@kernel.org>
Autocrypt: addr=geliang@kernel.org; prefer-encrypt=mutual;
 keydata=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
 Px+2P2cKc7LXXedb/qQ3M
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.54.0-1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

On Mon, 2024-12-16 at 11:39 +0100, Matthieu Baerts (NGI0) wrote:
> Two operations didn't have a small description. It looks like
> something
> that has been missed in the original commit introducing this file.
> 
> Replace the two 'todo' by a small and simple description:
> Create/Destroy
> subflow.
> 
> Fixes: bc8aeb2045e2 ("Documentation: netlink: add a YAML spec for
> mptcp")
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
>  Documentation/netlink/specs/mptcp_pm.yaml | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/netlink/specs/mptcp_pm.yaml
> b/Documentation/netlink/specs/mptcp_pm.yaml
> index
> 59087a23056510dfb939b702e231b6e97ae042c7..a9519ae77d38ce2af58de77c059
> ef22cd2e3f563 100644
> --- a/Documentation/netlink/specs/mptcp_pm.yaml
> +++ b/Documentation/netlink/specs/mptcp_pm.yaml
> @@ -375,7 +375,7 @@ operations:
>             - loc-id
>      -
>        name: subflow-create
> -      doc: todo
> +      doc: Create subflow
>        attribute-set: attr
>        dont-validate: [ strict ]
>        flags: [ uns-admin-perm ]
> @@ -387,7 +387,7 @@ operations:
>              - addr-remote
>      -
>        name: subflow-destroy
> -      doc: todo
> +      doc: Destroy subflow
>        attribute-set: attr
>        dont-validate: [ strict ]
>        flags: [ uns-admin-perm ]

This patch looks good! Thanks.

I think other three doc needs to be updated too:

"flush addresses", "announce new sf", "announce removal"

->

"Flush addresses", "Announce new address (?)", "Remove address (?)"

WDYT?

-Geliang

