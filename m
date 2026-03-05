Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FAB35898
	for <mptcp@lists.linux.dev>; Thu,  5 Mar 2026 04:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772685011; cv=none; b=XV3cVN/dJeZdRx0r2A+ud+jNP214fiuDXHv/2nrHAEqv/jxK8ybCf+tlLvBBX8b6UlElCzlhCQNxrske9Uq+Pucz2zpPi24kSXi2XJG+agl/bmvii4SrXDkXAnSGOzjRbsLwLvt3f8tHBo+ToZ3ydIXJSFXb3pN0B+ZJikAiYfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772685011; c=relaxed/simple;
	bh=sDLL6kdLLLH5WQ7xMSOZqNd8dwEuaVg6Hh8JLKgdj74=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=umGgkxuQrLj8gBVqsjoPlt3jmd9BF7J+i3prrlGoEnihDrD1/buzbtUn6HwlfBhJDJgrT1bMEIpZ2ihKDEzgF8CNgmSKEx0euEyu6KotDbsNv6PkUAsnuYPPcTFvoDtNoq9H3ofwpha+gdEhahIOxoOTC05MiJPcjBQR71hVTFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZUMShbbq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZUMShbbq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12CDBC116C6;
	Thu,  5 Mar 2026 04:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772685011;
	bh=sDLL6kdLLLH5WQ7xMSOZqNd8dwEuaVg6Hh8JLKgdj74=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=ZUMShbbqoby9u5IISgTeqFjl946q/mr9RwRks6xX4G0+/0f8DsySJIsW+EVX7AhkE
	 TMX+AYIiJY9rSx2G99uZzy/sHKioM3KFhKaqi5DfWg7qitbd59kZO9Jt5dXYybVTuI
	 eVonb+pEe0SKtkHW4Me1cRelNTfYth2WEf5V9vRY4r9sIfiNdUVAy2LowRC4iZUDmj
	 R2PzWReSe6idGrhSqDga1q+03N9w22/zaOzbz7okaUnvajmq3UEZdhTRm7eID1vkR1
	 O3OzNYhJTcxg6B6LQZZRobXoM0UTj1mRk3Bspdm6ndnFediHiQo9DJKhAqTyBTJMpF
	 aECdJuXGY4cgw==
Message-ID: <ffc23fb3bc82988608237be48a3eea7fdd3a4dd7.camel@kernel.org>
Subject: Re: [LSF/MM/BPF TOPIC] NVMe over MPTCP: Multi-Fold Acceleration for
 NVMe over TCP in Multi-NIC Environments
From: Geliang Tang <geliang@kernel.org>
To: Nilay Shroff <nilay@linux.ibm.com>, lsf-pc@lists.linux-foundation.org, 
	linux-nvme@lists.infradead.org, Ming Lei <ming.lei@redhat.com>, Javier
 =?ISO-8859-1?Q?Gonz=E1lez?=
	 <javier.gonz@samsung.com>
Cc: mptcp@lists.linux.dev, Matthieu Baerts <matttbe@kernel.org>, Mat
 Martineau	 <martineau@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Hannes
 Reinecke	 <hare@suse.de>
Date: Thu, 05 Mar 2026 12:30:06 +0800
In-Reply-To: <ecb30d89b67b992bfc136186f18550f9fb974baa.camel@kernel.org>
References: <a9f115aa5719e1088702a3fdeee766a3166611b1.camel@kernel.org>
		 <48e429f3-e29f-4eac-b4d3-3bf9e0d1c245@linux.ibm.com>
	 <ecb30d89b67b992bfc136186f18550f9fb974baa.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Hi Nilay, Ming,

Thank you again for your interest in NVMe over MPTCP.

On Thu, 2026-02-26 at 17:54 +0800, Geliang Tang wrote:
> Hi Nilay,
> 
> Thanks for your reply.
> 
> On Wed, 2026-02-25 at 20:37 +0530, Nilay Shroff wrote:
> > 
> > 
> > On 1/29/26 9:43 AM, Geliang Tang wrote:
> > > 3. Performance Benefits
> > > 
> > > This new feature has been evaluated in different environments:
> > > 
> > > I conducted 'NVMe over MPTCP' tests between two PCs, each
> > > equipped
> > > with
> > > two Gigabit NICs and directly connected via Ethernet cables.
> > > Using
> > > 'NVMe over TCP', the fio benchmark showed a speed of
> > > approximately
> > > 100
> > > MiB/s. In contrast, 'NVMe over MPTCP' achieved about 200 MiB/s
> > > with
> > > fio, doubling the throughput.
> > > 
> > > In a virtual machine test environment simulating four NICs on
> > > both
> > > sides, 'NVMe over MPTCP' delivered bandwidth up to four times
> > > that
> > > of
> > > standard TCP.
> > 
> > This is interesting. Did you try using an NVMe multipath iopolicy
> > other
> > than the default numa policy? Assuming both the host and target are
> > multihomed,
> > configuring round-robin or queue-depth may provide performance
> > comparable
> > to what you are seeing with MPTCP.
> > 
> > I think MPTCP shall distribute traffic using transport-level
> > metrics
> > such as
> > RTT, cwnd, and packet loss, whereas the NVMe multipath layer makes
> > decisions
> > based on ANA state, queue depth, and NUMA locality. In a setup with
> > multiple
> > active paths, switching the iopolicy from numa to round-robin or
> > queue-depth
> > could improve load distribution across controllers and thus improve
> > performance.
> > 
> > IMO, it would be useful to test with those policies and compare the
> > results
> > against the MPTCP setup.
> 
> Ming Lei also made a similar comment. In my experiments, I didn't set
> the multipath iopolicy, so I was using the default numa policy. In
> the
> follow-up, I'll adjust it to round-robin or queue-depth and rerun the
> experiments. I'll share the results in this email thread.

Based on your feedback, I have added iopolicy support to the NVMe over
MPTCP selftest script (see patch 8 in [1]). We can set the iopolicy to
round-robin like this:

 # ./mptcp_nvme.sh mptcp round-robin

This demonstrates that "NVMe over MPTCP" and "NVMe multipath" can work
simultaneously without conflict.

Using this test script, I compared three I/O policies: numa, round-
robin, and queue-depth. The results for fio were very similar. It's
possible that this test environment doesn't fully reflect the
differences in I/O policies. I will continue to follow up with further
tests.

Thanks,
-Geliang

[1]
NVME over MPTCP, v4
https://patchwork.kernel.org/project/mptcp/cover/cover.1772683110.git.tanggeliang@kylinos.cn/

> 
> Thanks,
> -Geliang
> 
> > 
> > Thanks,
> > --Nilay
