Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E446ADB
	for <mptcp@lists.linux.dev>; Mon, 24 Oct 2022 22:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666649070; x=1698185070;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=o6EZzwIuG3lKm3iYYLguTM9aIweOE9YaLFfrddeogvQ=;
  b=MrEI/d0sZ9hjrd/JGF94/A8eRPEI9FCE5P+O8uhdv0Y1FEB0yi34wAtX
   esVLBkPBvSY2xsQ7fV2x8BFzRp+QD4LzyLJz9A5DYclbslDnTTRkmaMaF
   07pedSQiB7CzToAlMyo/qdN8uNL0fpGHLiwj3V+Ceypm8hhx5BhhAHLJc
   Ck1qEF+kqfoCPZBZ+9kgCZlKW1dG88O3TCM511zm/cHEa7iOFEAix+0NP
   gr2PSWuwFiXGM9hd9NHTpmLU8d5f0GTPjielQeltPKlbOWC/O8qL7XDS8
   jvZV3Tiu9eiV4ohMP+BY6vldPLF2qvSmhGAZorQlXSy3DYnsAMi9cqrlS
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="306264079"
X-IronPort-AV: E=Sophos;i="5.95,210,1661842800"; 
   d="scan'208";a="306264079"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 15:04:29 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="631415597"
X-IronPort-AV: E=Sophos;i="5.95,210,1661842800"; 
   d="scan'208";a="631415597"
Received: from mlotfi-mobl.amr.corp.intel.com ([10.212.254.208])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 15:04:29 -0700
Date: Mon, 24 Oct 2022 15:04:28 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: wangjianli <wangjianli@cdjrlc.com>
cc: Bagas Sanjaya <bagasdotme@gmail.com>, 
    Matthieu Baerts <matthieu.baerts@tessares.net>, 
    David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
    Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
    netdev@vger.kernel.org, mptcp@lists.linux.dev, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/mptcp: fix repeated words in comments
In-Reply-To: <Y1VF1DBYePbkTk8x@debian.me>
Message-ID: <162b5545-7d24-3cf2-9158-3100ef644e03@linux.intel.com>
References: <20221022070527.55960-1-wangjianli@cdjrlc.com> <Y1VF1DBYePbkTk8x@debian.me>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Sun, 23 Oct 2022, Bagas Sanjaya wrote:

> On Sat, Oct 22, 2022 at 03:05:27PM +0800, wangjianli wrote:
>> Delete the redundant word 'the'.
>>
>> Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
>> ---
>>  net/mptcp/token.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/net/mptcp/token.c b/net/mptcp/token.c
>> index f52ee7b26aed..b817c2564300 100644
>> --- a/net/mptcp/token.c
>> +++ b/net/mptcp/token.c
>> @@ -287,7 +287,7 @@ EXPORT_SYMBOL_GPL(mptcp_token_get_sock);
>>   * This function returns the first mptcp connection structure found inside the
>>   * token container starting from the specified position, or NULL.
>>   *
>> - * On successful iteration, the iterator is move to the next position and the
>> + * On successful iteration, the iterator is move to the next position and
>>   * the acquires a reference to the returned socket.
>>   */
>>  struct mptcp_sock *mptcp_token_iter_next(const struct net *net, long *s_slot,
>
> NAK!
>
> Instead, slightly reword the comment above as "On successful iteration,
> the iterator moves to the next position and acquires a reference to the
> returned socket.".
>

Agree on this rewording.

This particular duplicated word came up before, and I thought it would be 
best if the author sent a v2 - but they never did. I will fix this in the 
MPTCP tree next week if there's no suitable v2 by then.

--
Mat Martineau
Intel
