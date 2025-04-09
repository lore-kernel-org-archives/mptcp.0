Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F84C1DF244
	for <mptcp@lists.linux.dev>; Wed,  9 Apr 2025 06:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744181441; cv=none; b=PK/t0/NrrVrAVXigICjlBUBE2aenN0OfkZNxjvFwh3p3x55Lx6Lh9F2fe8KJPCLVala4UK0FLzEgUZ5NwB9pz41mrrMeZYXtnTJH2RnzwsAMih1Aww2NY7THlJdNVX0BSsXMTVktsV9bMfdt/d0zQejVcwf8jT99MdmQL0/zog4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744181441; c=relaxed/simple;
	bh=WOOx6bQk1F4zL13ouTPu1qF1fplx2IMXFNOQyXGmb3U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WPCFhNAHEu/WczUg1XhCxJVmF627Q26+9HuixtZ8OkqIJIR3lKL0xH2oGm25oHKNT2MJOj111Q7xPoTDe+P+3pd2PZAPiQ1mEKcPnnxAtLUuxpkkSez5ZINZn0gMsBotIyVWrEGW9tDPjD83iOqmhggQcURFSw92mZ2epUPz8mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i2HWWKli; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i2HWWKli"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C08DCC4CEE7;
	Wed,  9 Apr 2025 06:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744181440;
	bh=WOOx6bQk1F4zL13ouTPu1qF1fplx2IMXFNOQyXGmb3U=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=i2HWWKliR5vBr6PCNcComC6+lPzPREh1kwYAlAeBY2dYSh7UnVldsoAOzIzWv4Mek
	 DQrWReLqUA0/LrbEH31qBCwKDdpUQF6RD0dxhGNXc4VL0sHQrv4aA0njXOXg7bVV2t
	 NDS/ji/Zoc9Xcx2lua4Fq4GmgIPrgnccBMlKrt7AmnpM8gFsL5Q4AS08yHJNrcTEQS
	 xvTUZ/lfk4r9zZK/DVWjzJozWgasVAO6j9GxM9vt03aQOFCFoyPlCZtYVPB86hbfvA
	 7lH1H0pDcFyCZ/X8z+3+1G5YC02LNhdzsjzfrI5KZ33CJWiWavKZy7fOTE7QLaa6cz
	 s0nbsgOX2vM4w==
Message-ID: <89c3c82810d877f49f886e2ba10a34fab99cd7e8.camel@kernel.org>
Subject: Re: [PATCH mptcp-next 1/3] mptcp: pm: userspace: local_addr_used--
 after sending REMOVE_ADDR
From: Geliang Tang <geliang@kernel.org>
To: Mat Martineau <martineau@kernel.org>
Cc: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>
Date: Wed, 09 Apr 2025 14:50:36 +0800
In-Reply-To: <aabfdca3-0f10-08d5-98db-d322bab7c87a@kernel.org>
References: <cover.1743562290.git.tanggeliang@kylinos.cn>
	 <4f0b16c622b2714069acf8607de0d4e7f0c013ea.1743562290.git.tanggeliang@kylinos.cn>
	 <aabfdca3-0f10-08d5-98db-d322bab7c87a@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Hi Mat,

Thanks for the review.

On Tue, 2025-04-08 at 16:51 -0700, Mat Martineau wrote:
> On Wed, 2 Apr 2025, Geliang Tang wrote:
> 
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> > 
> > Address entries are removed from local_addr_list when sending a
> > REMOVE_ADDR
> > by the userspace PM, the local_addr_used counter of PM should also
> > be
> > decremented accordingly.
> > 
> > Fixes: d9a4594edabf ("mptcp: netlink: Add MPTCP_PM_CMD_REMOVE")
> > Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> > ---
> > net/mptcp/pm_userspace.c | 1 +
> > 1 file changed, 1 insertion(+)
> > 
> > diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
> > index 7fc19b844384..db471eb836b3 100644
> > --- a/net/mptcp/pm_userspace.c
> > +++ b/net/mptcp/pm_userspace.c
> > @@ -331,6 +331,7 @@ int mptcp_pm_nl_remove_doit(struct sk_buff
> > *skb, struct genl_info *info)
> > 	}
> > 
> > 	list_del_rcu(&match->list);
> > +	msk->pm.local_addr_used--;
> > 	spin_unlock_bh(&msk->pm.lock);
> > 
> > 	mptcp_pm_remove_addr_entry(msk, match);
> 
> 
> Hi Geliang -
> 
> This should be squashed with patch 2, since it's not bisectable

Sure. Will squash it in v2.

Thanks,
-Geliang

> (wouldn't 
> want this patch to get cherry-picked without the other, and have the 
> variable decremented twice).
> 
> 
> 
> - Mat

