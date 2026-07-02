Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C129632C8B
	for <mptcp@lists.linux.dev>; Thu,  2 Jul 2026 03:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782961862; cv=none; b=oo8OkguH9avJVVaHJXZOkTFDdk2euftl6qD+wh6k3tNaCRmOn/xiEBRkc/o+FdwF7oeApLGqR705bOH+kfRO5DGnstEU6JgmdCMyeHqt4pJREbSOEl1gDTBkBPXWHutvlJTPFILSOY1v8LJvW824C2nstddjAaDTDlq/3l1Kv5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782961862; c=relaxed/simple;
	bh=63nU8GHHqzgQMf/icGIzJhYShWuZJHEA8CEfYhYAZzk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GiDFGM95wSx7pX2pgomTdny9gl961BpzAlU2Kt5PQELG+Zy85dvR+BvtQx+5W88pXOWkg0udcdXtbYst3XHA4iyzQtDOmPAinQkPraaCup6bTGVk7v/jUDI57ne2WIKdML0VWSyzZqXhamhc4t5DRmVNnKe1BjxvXEh5H1sIzI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jD57zbyY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jD57zbyY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAD861F000E9;
	Thu,  2 Jul 2026 03:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782961861;
	bh=oirK1OOBZRVhMrWj8yZDxLaPlNekiorq7nxSsJOFESk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=jD57zbyY1wjxkiP61jmGhPth88G0XM/wBXZpso4eqPzqY2M98yJf8x0+LBSPTRvtx
	 td3PJWvqvBuBV/5NxS4Gvf0LVVrKuxr0oGjNY71LBZcJnLSQaoG8cTuj04ieilEaUe
	 EAsXZE5KPXlritOaE77bF6jYscKBy9pZ3gxb9/JprAnhg00KmJHR3HlSopeamZwOvn
	 5CSyxaYiZcMWJ+xzs/7ue95PdUKm5WewftoYDJa2vlcpOSV5IK43gAtP5f035G/O9o
	 F1OjPvUg22dljfRiWaP+9qMUGuhe7TVFzERQdX3xQwWhcj6pYFVkaAP5ueWp2TGw37
	 xmYKBmN2vYpaQ==
Message-ID: <3ee58e345f2538099d794c26425a0df33d3e803f.camel@kernel.org>
Subject: Re: [PATCH] selftests: mptcp: mptcp_diag: fix stack buffer overflow
 in get_subflow_info()
From: Geliang Tang <geliang@kernel.org>
To: Jiangshan Yi <yijiangshan@kylinos.cn>
Cc: mptcp@lists.linux.dev
Date: Thu, 02 Jul 2026 11:10:55 +0800
In-Reply-To: <8ac216a4fbdfe35b6cbd2a2e9373495cbc009ee7.camel@kernel.org>
References: <20260701103809.4051377-1-yijiangshan@kylinos.cn>
	 <8ac216a4fbdfe35b6cbd2a2e9373495cbc009ee7.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 2026-07-02 at 11:06 +0800, Geliang Tang wrote:
> Hi Jiangshan,
> 
> On Wed, 2026-07-01 at 18:38 +0800, Jiangshan Yi wrote:
> > get_subflow_info() parses the subflow address string with:
> > 
> > 	char saddr[64], daddr[64];
> > 
> > 	ret = sscanf(subflow_addrs, "%[^:]:%d %[^:]:%d",
> > 		     saddr, &sport, daddr, &dport);
> > 
> > The subflow_addrs buffer holds up to 1024 bytes and is taken
> > directly
> > from the command line ("-c" argument). The "%[^:]" conversions have
> > no
> > maximum field width, so if the address substring before the ':'
> > exceeds
> > 63 bytes, sscanf() writes past the end of the 64-byte saddr/daddr
> > stack
> > buffers. This overflows the stack, corrupting adjacent stack data
> > such
> > as the saved return address, and can crash the tool or lead to
> > out-of-bounds writes controlled by user-supplied input.
> > 
> > Bound both string conversions to the destination buffer size by
> > adding
> > an explicit maximum field width of 63 (leaving room for the
> > terminating
> > NUL), so at most 63 bytes are written into each 64-byte buffer:
> > 
> > 	ret = sscanf(subflow_addrs, "%63[^:]:%d %63[^:]:%d",
> > 		     saddr, &sport, daddr, &dport);
> > 
> > Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>
> > ---
> >  tools/testing/selftests/net/mptcp/mptcp_diag.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/testing/selftests/net/mptcp/mptcp_diag.c
> > b/tools/testing/selftests/net/mptcp/mptcp_diag.c
> > index 5e222ba977e4..02ac93f794fe 100644
> > --- a/tools/testing/selftests/net/mptcp/mptcp_diag.c
> > +++ b/tools/testing/selftests/net/mptcp/mptcp_diag.c
> > @@ -377,7 +377,7 @@ static void get_subflow_info(char
> > *subflow_addrs)
> >  	int ret;
> >  	int fd;
> >  
> > -	ret = sscanf(subflow_addrs, "%[^:]:%d %[^:]:%d", saddr,
> > &sport, daddr, &dport);
> > +	ret = sscanf(subflow_addrs, "%63[^:]:%d %63[^:]:%d",
> > saddr,
> > &sport, daddr, &dport);
> 
> Thanks for this patch. MPTCP CI complains:
> 
> WARNING: line length of 91 exceeds 80 columns
> #44: FILE: tools/testing/selftests/net/mptcp/mptcp_diag.c:380:
> 
> Also, for the subject prefix, we usually use "selftests: mptcp:
> diag:"
> instead of "selftests: mptcp: mptcp_diag:". Please consider updating
> it
> if you spin a v2.

Also, when you send v2, please only CC the MPTCP mailing list
(mptcp@lists.linux.dev); there's no need to CC netdev or other mailing
lists.

Thanks,
-Geliang

> 
> Thanks,
> -Geliang
> 
> >  	if (ret != 4)
> >  		die_perror("IP PORT Pairs has style problems!");
> >  
> 
> 

