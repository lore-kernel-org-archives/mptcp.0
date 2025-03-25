Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A342594BD
	for <mptcp@lists.linux.dev>; Tue, 25 Mar 2025 12:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742907107; cv=none; b=TapOR3lhSd0NLZwa2MJ8pEUmzEYGjDw29OweHWkzCE/K8kWyfMvluuAE/dyyGwlPM2/RaLJI41+6T1ADXuhfyBoiD3fuzwljREdslRiUM4UknGx3N1Iwi+aU50yeUTzudNwxnGNP0gqaZVY/KrLxVpr2qi4XT8lY10xWyJ+7vWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742907107; c=relaxed/simple;
	bh=04WyPtnaqXX/qjdJRYC16LNgsnbV5owsAL6ATqenmEQ=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=c/5aSpQ9QFVOb2E2tCpkM2siF9euizyewFU60x8mZzA4nLgmcm5dBZPMcagxIOKT0ofvtLnFSPeHzS03PBVoKM9nmbFX4JF2lctmQ4APaAFKHjEFb+9GvU3ELLss01Tboj2B7vxkQMUGF57oP0cRQOFQVIs7xaqY5hUnwYc4Ec0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DDalLAdL; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DDalLAdL"
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742907102;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IOe5X9hTl3U+JuiEs3iaGAEn3PxEP3IbrqzHiKu85PU=;
	b=DDalLAdLc1qsrGojQfDv+X25eSAk9RrKF+RV8ZtD97V3nbAiMOhFWvAKek/ziJqHzxMzFo
	KJioyNTcyN+0FbwfqSSrxT75ynzhZo4+MPlOXhd5HPXdxqB4Wikq7M2pfZZDVSuWvz1Y/I
	zUOfOR9vV5WiNaEJvdDw1tUNIAN6BT4=
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.1\))
Subject: Re: [PATCH net-next] mptcp: pm: Fix undefined behavior in
 mptcp_remove_anno_list_by_saddr()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <20250325053058.412af7c5@kernel.org>
Date: Tue, 25 Mar 2025 13:51:28 +0100
Cc: Matthieu Baerts <matttbe@kernel.org>,
 Mat Martineau <martineau@kernel.org>,
 Geliang Tang <geliang@kernel.org>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org,
 mptcp@lists.linux.dev,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <7EEE7001-CCD4-4A5A-8723-3AAC3A88F6FF@linux.dev>
References: <20250325110639.49399-2-thorsten.blum@linux.dev>
 <7F685866-E146-4E99-A750-47154BDE44C6@linux.dev>
 <20250325053058.412af7c5@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
X-Migadu-Flow: FLOW_OUT

On 25. Mar 2025, at 13:30, Jakub Kicinski wrote:
> On Tue, 25 Mar 2025 12:33:11 +0100 Thorsten Blum wrote:
>> On 25. Mar 2025, at 12:06, Thorsten Blum wrote:
>>> 
>>> Commit e4c28e3d5c090 ("mptcp: pm: move generic PM helpers to pm.c")
>>> removed a necessary if-check, leading to undefined behavior because
>>> the freed pointer is subsequently returned from the function.
>>> 
>>> Reintroduce the if-check to fix this and add a local return variable to
>>> prevent further checkpatch warnings, which originally led to the removal
>>> of the if-check.
>>> 
>>> Fixes: e4c28e3d5c090 ("mptcp: pm: move generic PM helpers to pm.c")
>>> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
>>> ---  
>> 
>> Never mind, technically it's not actually undefined behavior because of
>> the implicit bool conversion, but returning a freed pointer still seems
>> confusing.
> 
> CCing the list back in.

Thanks!

The change imo still makes sense, but the commit message should be
updated. I'll submit a new patch for after the merge window.

