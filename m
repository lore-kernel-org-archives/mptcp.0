Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA3139E181
	for <mptcp@lists.linux.dev>; Thu, 26 Feb 2026 09:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772099675; cv=none; b=XKZkJ9EO0Cm0x1axwE+r1d2YXjxfBFmMuYf2KGOBvf9PS1aRH92v2LkJQ2I6sqjdMBl+02YGKJsuPWW+rK0dC/RKOwpzKjTbcSDjIvek3M5ctb3+zC8qaoBZ2dfO0nOe/Jv73NMcikOF87b912qUq0Hb5DrreZwPMui6QU8l0TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772099675; c=relaxed/simple;
	bh=YflxXBI6fKxopNaF1Fz3pgT4eJ0/VdR7f2V2GZ6OgH4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QWaaZ4aUyg2xMp/mAu9FtfPjle2+tO7yIx3DjjQM8aoXZwi7b5VfYN3BPRJCr1eSBPTiazPc7SdiCl658RpzsoJvOGNb5u+ETLVRq/mQfU1MCk1OFi5+Tqh6l4iGbMfMngY3ZpnwjQi044v1K0e6kZfuUXf31y+O2NIAMpu8SG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ATNOf1Fm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ATNOf1Fm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A698BC19422;
	Thu, 26 Feb 2026 09:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772099675;
	bh=YflxXBI6fKxopNaF1Fz3pgT4eJ0/VdR7f2V2GZ6OgH4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=ATNOf1FmNKADMbM3w7ObC1TZz/3ZxKRhEPzFrOnAbXn1Or3oSycXbhHsDmBhAfMTX
	 cRtCV1dJRDHfFdFxyFID7QK+wD7vvbqmypqrAHsRiI3LOHgPeewTrd+l9b91ZrySXw
	 T9iW78/0bHlVoMQyBvcTFGJRDkUsBdONp+YLhuhk5jt+cOfHbQD9YjS7musecMozOq
	 v0dJdjjGY/1SpHWuFM80xfNX28KUa5zsG7W4QA6qX8CT/RpeeBGbtD7QVShm53i7+Q
	 C8lGChbNndGKmBTYN28krvEX4tSaY8h7djC0aEz/yL2hczcdKSploEG6U9Nod6rtPj
	 ys7T51REGGq7w==
Message-ID: <ecb30d89b67b992bfc136186f18550f9fb974baa.camel@kernel.org>
Subject: Re: [LSF/MM/BPF TOPIC] NVMe over MPTCP: Multi-Fold Acceleration for
 NVMe over TCP in Multi-NIC Environments
From: Geliang Tang <geliang@kernel.org>
To: Nilay Shroff <nilay@linux.ibm.com>, lsf-pc@lists.linux-foundation.org, 
	linux-nvme@lists.infradead.org
Cc: mptcp@lists.linux.dev, Matthieu Baerts <matttbe@kernel.org>, Mat
 Martineau	 <martineau@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Hannes
 Reinecke	 <hare@suse.de>
Date: Thu, 26 Feb 2026 17:54:29 +0800
In-Reply-To: <48e429f3-e29f-4eac-b4d3-3bf9e0d1c245@linux.ibm.com>
References: <a9f115aa5719e1088702a3fdeee766a3166611b1.camel@kernel.org>
	 <48e429f3-e29f-4eac-b4d3-3bf9e0d1c245@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Hi Nilay,

Thanks for your reply.

On Wed, 2026-02-25 at 20:37 +0530, Nilay Shroff wrote:
> 
> 
> On 1/29/26 9:43 AM, Geliang Tang wrote:
> > 3. Performance Benefits
> > 
> > This new feature has been evaluated in different environments:
> > 
> > I conducted 'NVMe over MPTCP' tests between two PCs, each equipped
> > with
> > two Gigabit NICs and directly connected via Ethernet cables. Using
> > 'NVMe over TCP', the fio benchmark showed a speed of approximately
> > 100
> > MiB/s. In contrast, 'NVMe over MPTCP' achieved about 200 MiB/s with
> > fio, doubling the throughput.
> > 
> > In a virtual machine test environment simulating four NICs on both
> > sides, 'NVMe over MPTCP' delivered bandwidth up to four times that
> > of
> > standard TCP.
> 
> This is interesting. Did you try using an NVMe multipath iopolicy
> other
> than the default numa policy? Assuming both the host and target are
> multihomed,
> configuring round-robin or queue-depth may provide performance
> comparable
> to what you are seeing with MPTCP.
> 
> I think MPTCP shall distribute traffic using transport-level metrics
> such as
> RTT, cwnd, and packet loss, whereas the NVMe multipath layer makes
> decisions
> based on ANA state, queue depth, and NUMA locality. In a setup with
> multiple
> active paths, switching the iopolicy from numa to round-robin or
> queue-depth
> could improve load distribution across controllers and thus improve
> performance.
> 
> IMO, it would be useful to test with those policies and compare the
> results
> against the MPTCP setup.

Ming Lei also made a similar comment. In my experiments, I didn't set
the multipath iopolicy, so I was using the default numa policy. In the
follow-up, I'll adjust it to round-robin or queue-depth and rerun the
experiments. I'll share the results in this email thread.

Thanks,
-Geliang

> 
> Thanks,
> --Nilay
