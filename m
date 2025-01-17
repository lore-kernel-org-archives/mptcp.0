Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E72B645
	for <mptcp@lists.linux.dev>; Fri, 17 Jan 2025 00:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737072390; cv=none; b=ay8by702vbKAkb76x8xMAFmfbU4b30evHWIi/paQnw/yIbUlal0dSfhXxOOv0l7D3fPpcq7O6Ic1fd7iWILTqBcvCldNB2bK5XikS1MJyJhTL9aRLpxm5HqxZo7LVBCp7C5hS3scdtkSPp8VS3hg1ZJSvszbLFih3ooz0UNnvFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737072390; c=relaxed/simple;
	bh=W+/ZMCFfF8UkxRFqpc3P08yqu1zQ/77bHNhaViYZCio=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CqRE+UHZuMsGyISV0rmzq/rivMj1ZGAEwb1gzudt4ppB7zfu/Gk9iosizNpKQx5GJi0hDDx+y/06d+XEMMPXrpadtyjVgw0xgiOq+fwSZKavUYbj1XTTHkd43EsdkCI+CtxyqDyDkvakxIWve3a98lFM4AyAUOCy+vPPo/+p5OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rZ6OoCkm; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rZ6OoCkm"
Message-ID: <6645ad6e-8874-44c5-8730-854c30673218@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1737072386;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8FEV71PljjkgDpPNVt8LCNrRV5CglqTpIhlGFqVJkgI=;
	b=rZ6OoCkmqqFXSQJQZqe8jN+35THxZCl41T61VqJOv+fJ1WxZ9/FDTuqQLGwsO94rndYxI1
	0DEWcr6/CI5iD5+vwsbYv/Bz0cZPcKh+KL8vnebvk/9btngqIY2dpIdkMkvkBS8dp9AlrY
	fw+s9KawbA8yfGTBH/97htQ9IYafBns=
Date: Thu, 16 Jan 2025 16:06:17 -0800
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next/net v2 0/7] bpf: Add mptcp_subflow bpf_iter
 support
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Martin KaFai Lau <martin.lau@kernel.org>,
 mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>,
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Shuah Khan <shuah@kernel.org>
References: <20241219-bpf-next-net-mptcp-bpf_iter-subflows-v2-0-ae244d3cdbbc@kernel.org>
 <1ff05fca-28ff-491e-ab4e-b562d310359b@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <1ff05fca-28ff-491e-ab4e-b562d310359b@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/15/25 1:39 AM, Matthieu Baerts wrote:
>> Here is a series from Geliang, adding mptcp_subflow bpf_iter support.
>>
>> We are working on extending MPTCP with BPF, e.g. to control the path
>> manager -- in charge of the creation, deletion, and announcements of
>> subflows (paths) -- and the packet scheduler -- in charge of selecting
>> which available path the next data will be sent to. These extensions
>> need to iterate over the list of subflows attached to an MPTCP
>> connection, and do some specific actions via some new kfunc that will be
>> added later on.
> 
> (...)
> 
>> Changes in v2:
>> - Patches 1-2: new ones.
>> - Patch 3: remove two kfunc, more restrictions. (Martin)
>> - Patch 4: add BUILD_BUG_ON(), more restrictions. (Martin)
>> - Patch 7: adaptations due to modifications in patches 1-4.
>> - Link to v1: https://lore.kernel.org/r/20241108-bpf-next-net-mptcp-bpf_iter-subflows-v1-0-cf16953035c1@kernel.org
> 
> The v2 of this series didn't get any reviews, probably because it has
> been sent the week before Xmas. Do you prefer if I resend it?

No need to resend. will get to it.

