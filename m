Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CFFA2BDC1C
	for <mptcp@lists.linux.dev>; Thu,  3 Sep 2026 06:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788418504; cv=none; b=WiVhxh+yaV8AxRhVb3PXcAqM7SZg2o+0X8YrjoANKLLugBsWnh0FZRYb7zTkdLOSWfh+TXJWg1N8CeEZ2zq8zvRU4LNCMA3c5f3Dy/X2BVQDTGawfnVegeSMOKFC2hXdTJoonScH+1JmOGjaI9IGSbkHbxilc8Mpo1MgH8iwpok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788418504; c=relaxed/simple;
	bh=5wEaZF6e8BMdEj4rJQ9lXNiJTWI6Q2xC5GPwItIThRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QIxbITHRrykxeal8ssgqYZ8Fa4ZH0yUNNpW5RNfdX0pkb83Lye7gzT+wlcV44Ywerx5YOGz7iJztag6FPkA6goEmgPWx6o0pI/MCv25Ar81qRWdfx1LamfARAP+msa3lmyxbq0Ded6pCiAmT5kRZqw4Dmg+XlmUPMqPCOKAPmDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id F22116032B; Thu, 03 Sep 2026 08:54:53 +0200 (CEST)
Date: Thu, 3 Sep 2026 08:54:53 +0200
From: Florian Westphal <fw@strlen.de>
To: Hangbin Liu <hangbin.liu@linux.dev>
Cc: Matthieu Baerts <matttbe@kernel.org>,
	MPTCP Linux <mptcp@lists.linux.dev>
Subject: Re: [PATCH mptcp-next 2/2] selftests: mptcp: convert iptables to
 nftables for mptcp_join.sh
Message-ID: <apkZt2gscN_3h3d3@strlen.de>
References: <20260902-mptcp_nft-v1-0-559caa16f410@kylinos.cn>
 <20260902-mptcp_nft-v1-2-559caa16f410@kylinos.cn>
 <513e6559-a06a-45d8-a8b7-72b3a1a77e71@kernel.org>
 <apjU-uM8dvxnVcaP@fedora>
 <apkVLlKisTGIS_n_@fedora>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apkVLlKisTGIS_n_@fedora>

Hangbin Liu <hangbin.liu@linux.dev> wrote:
> The time for nft version is
> 
> real    43m37.393s
> user    0m29.183s
> sys     32m15.354s
> 
> I will find a way to only add the table when needed.

If you have to adjust this anyway, can you also change this to

... exec nft -f - <<EOF
add table ..
add chain ..
EOF

?

No need to call the binary for every single action.
Thanks!
