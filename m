Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5C318801A
	for <mptcp@lists.linux.dev>; Mon, 20 Jan 2025 09:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737366932; cv=none; b=GXynJYvG3uPZesPfBYeexPNmUXlaYOOPuY6KEZAASR9Xa2GgInfoj0CIgOBwgPXILsrDBHuggJauHWg8RTr0bA8Q+Gn6IZX/WEhM8cIwd2wGNklpNJh4JWUbqI5GPIomhpmsvglvXbHswUdWGxq7vDLAmPhhGTyGIpkXRL4Dv2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737366932; c=relaxed/simple;
	bh=7gZLn2pEcfH9mRPKxDBIxH0GHTpyABTaOCkFMZT0sOQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ezj0ih61hwkF2W4lZEw7fuVDQzCp1/o5Yus6RwRuHndT1QKBkjV0RscWNhxEqZpIgiQuNd4zQa/SCAQVKSKrG5p+Roe1Vripd2l/WlybVywG8j6+dlMuuxU1HZxeJWauTM6JQ8r+kqf5wzxA8hJ1WRzQLZ+6BX8prSZvwKcWuis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BY7LQCPE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BY7LQCPE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DBDCC4CEDD;
	Mon, 20 Jan 2025 09:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737366931;
	bh=7gZLn2pEcfH9mRPKxDBIxH0GHTpyABTaOCkFMZT0sOQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=BY7LQCPEuqV5BmvTvlYiUI/s9W5WG25SCe8ZkOFi5UGGe/HYpNkWIjrxtZoSBOn40
	 6zkxC/0uu1O3Ydizwl7fHbNdbCuvTiTbFUEBRqvHX0GwrXRxY87sa9dTPF9/cKmK8E
	 BwzjCL48BcmRq+k2qvV48R6kPB0uELiEvsb7loAnesiUJ5O6H+mb7xS9IvnPhxazQE
	 D7//TQxDVb2gLgITxI4wqOZf1JjXr13yegGmN1S8lJI/aEhx3CJ+Qgff0gcAPaQjhr
	 T7eclI1GnwZgT7EVZwe9saa7l8lqTC4zSaHmWpQegaLI5/SORFxP6u+T769WZ/Pvcl
	 THGo94Fr2R9RQ==
Message-ID: <20ba4326de28634dec5845604720a4a276438e4e.camel@kernel.org>
Subject: Re: [PATCH mptcp-next] Squash to "mptcp: pm: add id parameter for
 get_addr"
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Date: Mon, 20 Jan 2025 17:55:28 +0800
In-Reply-To: <381923ac-bb94-4386-90a3-7d9cde7ed468@kernel.org>
References: 
	<625cc0fceb9d347ed6a029396a8d202cbb24d2c4.1737156352.git.tanggeliang@kylinos.cn>
	 <e34a54e2-bf7b-47eb-89ac-80e5605955aa@kernel.org>
	 <44df209fd690c009ddbcafd5e2a6872b987da4e2.camel@kernel.org>
	 <381923ac-bb94-4386-90a3-7d9cde7ed468@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Mon, 2025-01-20 at 09:20 +0100, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 18/01/2025 11:54, Geliang Tang wrote:
> > Hi Matt,
> > 
> > On Sat, 2025-01-18 at 08:50 +0100, Matthieu Baerts wrote:
> > > Hi Geliang,
> > > 
> > > On 18/01/2025 00:26, Geliang Tang wrote:
> > > > From: Geliang Tang <tanggeliang@kylinos.cn>
> > > > 
> > > > No need to drop 'attr = info->attrs[MPTCP_PM_ENDPOINT_ADDR];'
> > > > in
> > > > mptcp_userspace_pm_get_addr() too, add it back.
> > > > 
> > > > Alse update mptcp_pm_nl_get_addr() to keep the original two-
> > > > line
> > > > assignment of 'attr'.
> > > 
> > > I did a simple fix instead, see 648a0809e4cf ("Squash to "mptcp:
> > > pm:
> > > add
> > > id parameter for get_addr"") and the final export branch. Tell me
> > > if
> > > that's not OK.
> > 
> > It works.
> > 
> > But we just change
> > 
> > 	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
> > 
> > to
> > 	struct nlattr *token;
> > 
> > 	token = info->attrs[MPTCP_PM_ATTR_TOKEN];
> > 
> > in patch 5 "mptcp: pm: userspace: use GENL_REQ_ATTR_CHECK".
> > 
> > We change it back again in this patch 11.
> > 
> > So I prefer to use the two-line assignment of 'attr'. But up to
> > you.
> 
> I see, it makes sense. But well, at the end, this code is going to be
> moved elsewhere. Because the modifications have already been done
> internally, I think it is fine to leave them like that, and avoid
> dealing with new conflicts.

Indeed, I agree.

Thanks,
-Geliang

> 
> Cheers,
> Matt

