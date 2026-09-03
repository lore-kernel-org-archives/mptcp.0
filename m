Received: from mta1.migadu.com (out-208.mta1.migadu.com [95.215.58.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C84F4503E5
	for <mptcp@lists.linux.dev>; Thu,  3 Sep 2026 07:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788420952; cv=none; b=pXj4MdQwBtuLO9uwUb7s4P7TbW0iuVgjn0zHb0kUWcOE158MB5zmCpDTKr3s9S38rThzdeZ0WkXMLh7NL5z1VivCnti/wmvKIBr0GJmMc+rCYO1gdyc19kPeLpSrdhg2H/FTBVw5ofZHnCoI2aoMEvLcq/yjqxH3LBW4Tdp+qEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788420952; c=relaxed/simple;
	bh=KOa0MUR3fYGcIvmKjMfwawWUcVKdHEtUxgFI18MG4C0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FSLangVk8jsdUmPQbu8uG7hdEiZNA9psPAsJrJ7UIClhLbZ9yduZ1EZwYvAjcCDeuB3MGZ2aPIPHgjKO+lZEr7L2JcjoulT8t/lLfAi11fzgcmK7UZYj6Qe/XvebcAVhibUMGS9lwAdgGB5Qa7LQovCfvToFcBM95jy3SrW7YzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xeUdN+pc; arc=none smtp.client-ip=95.215.58.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xeUdN+pc"
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=KOa0MUR3fYGcIvmKjMfwawWUcVKdHEtUxgFI18MG4C0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788420949; v=1; x=1789025749;
 b=xeUdN+pcuSpMOWyT585InS8+p/Uv9Bl2beXQIYszmT9FHz3fQUJIWckIOX0ByuGzbBTPjR+3
 ZhJfVa8N6NY7JYBr7skP+wAQZU5aFodTuu4dimYEQqln9mGfI8xG6EUKp4BZ60PgdsqTI2bI8OO
 RzttkYMPGXR+4txXYwMD8FFg=
X-Envelope-To: mptcp@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 39e4436cc3ff21c5;
	Thu, 03 Sep 2026 07:35:49 +0000
X-Mizu-Trace-ID: 39e4436cc3ff21c5
X-Migadu-Flow: FLOW_OUT
Date: Thu, 3 Sep 2026 15:35:41 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Florian Westphal <fw@strlen.de>
Cc: Matthieu Baerts <matttbe@kernel.org>,
	MPTCP Linux <mptcp@lists.linux.dev>
Subject: Re: [PATCH mptcp-next 2/2] selftests: mptcp: convert iptables to
 nftables for mptcp_join.sh
Message-ID: <apkjTRvhDx4WjW-k@fedora>
References: <20260902-mptcp_nft-v1-0-559caa16f410@kylinos.cn>
 <20260902-mptcp_nft-v1-2-559caa16f410@kylinos.cn>
 <513e6559-a06a-45d8-a8b7-72b3a1a77e71@kernel.org>
 <apjU-uM8dvxnVcaP@fedora>
 <apkVLlKisTGIS_n_@fedora>
 <apkZt2gscN_3h3d3@strlen.de>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apkZt2gscN_3h3d3@strlen.de>

Hi Florian,
On Thu, Sep 03, 2026 at 08:54:53AM +0200, Florian Westphal wrote:
> Hangbin Liu <hangbin.liu@linux.dev> wrote:
> > The time for nft version is
> > 
> > real    43m37.393s
> > user    0m29.183s
> > sys     32m15.354s
> > 
> > I will find a way to only add the table when needed.
> 
> If you have to adjust this anyway, can you also change this to
> 
> ... exec nft -f - <<EOF
> add table ..
> add chain ..
> EOF
> 
> ?
> 
> No need to call the binary for every single action.

Good, this could also save some time. Thanks for this tip.

Regards
Hangbin
