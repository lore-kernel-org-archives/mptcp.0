Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F27D259CBD
	for <mptcp@lists.linux.dev>; Thu, 14 Aug 2025 20:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755202924; cv=none; b=cLssZJBrOVtR5VVDThJqaz0aL2YYdilmIeG7ypADjLfoM9Sjw7j1ZdeWn+xCSGYwspB4C5MxWeul0NEmb3x4JzZxJfCEccWEqGFbRv0JLISFDTEoMX3WMyrVXj5tV53LXryAJe+w4ovhv2PjKz3906nLWGD+/Ksj9K20/Y48Db8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755202924; c=relaxed/simple;
	bh=889VYTRIrbL3AsWcOiJZXGuYshjOG6r3nV8h7mnZeGo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tO4qhgv7PpnW6jbspS2Yp8dGDkq6eXpwoTpuZ8elGX/OJxY3siWKFCU9fb7Whn1EiGVBN0R488zaaIouVpGibB40fxlM/8DNqRfLOPKhef2DXpF1+H1t2H0oJ7NEKwMag1Ytpx2nOljNKPm9I0oTHdFPo1/vWFgIkpB7H0vuT1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AYlpvdK7; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AYlpvdK7"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755202906;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=889VYTRIrbL3AsWcOiJZXGuYshjOG6r3nV8h7mnZeGo=;
	b=AYlpvdK7DjpVAS/UM1NYteoAytadnZdoVApEVlZwGSQBgzH6J+vMAPj4+JWjquYjK8X0z5
	eG9bgeus6GC4N1okdQkTVZW+gfU+jn+Mi/hNMgxrTijT6YWoZhufcdP1T+WSlKD36RdA3f
	XjhOHHO0bZbB9SDh0THNG9EOWeH6KEw=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,  Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Neal Cardwell
 <ncardwell@google.com>,  Paolo Abeni <pabeni@redhat.com>,  Willem de
 Bruijn <willemb@google.com>,  Matthieu Baerts <matttbe@kernel.org>,  Mat
 Martineau <martineau@kernel.org>,  Johannes Weiner <hannes@cmpxchg.org>,
  Michal Hocko <mhocko@kernel.org>,  Shakeel Butt <shakeel.butt@linux.dev>,
  Andrew Morton <akpm@linux-foundation.org>,  =?utf-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>,  Tejun Heo <tj@kernel.org>,  Simon Horman
 <horms@kernel.org>,  Geliang Tang <geliang@kernel.org>,  Muchun Song
 <muchun.song@linux.dev>,  Mina Almasry <almasrymina@google.com>,  Kuniyuki
 Iwashima <kuni1840@gmail.com>,  netdev@vger.kernel.org,
  mptcp@lists.linux.dev,  cgroups@vger.kernel.org,  linux-mm@kvack.org
Subject: Re: [PATCH v4 net-next 10/10] net: Define sk_memcg under CONFIG_MEMCG.
In-Reply-To: <20250814200912.1040628-11-kuniyu@google.com> (Kuniyuki
	Iwashima's message of "Thu, 14 Aug 2025 20:08:42 +0000")
References: <20250814200912.1040628-1-kuniyu@google.com>
	<20250814200912.1040628-11-kuniyu@google.com>
Date: Thu, 14 Aug 2025 13:21:24 -0700
Message-ID: <877bz5lkmz.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Kuniyuki Iwashima <kuniyu@google.com> writes:

> Except for sk_clone_lock(), all accesses to sk->sk_memcg
> is done under CONFIG_MEMCG.
>
> As a bonus, let's define sk->sk_memcg under CONFIG_MEMCG.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> Reviewed-by: Eric Dumazet <edumazet@google.com>

Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
