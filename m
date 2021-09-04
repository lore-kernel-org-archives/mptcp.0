Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1670B3FC0
	for <mptcp@lists.linux.dev>; Sat,  4 Sep 2021 08:00:30 +0000 (UTC)
Received: by mail-ej1-f51.google.com with SMTP id mf2so2642312ejb.9
        for <mptcp@lists.linux.dev>; Sat, 04 Sep 2021 01:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yl3cr9TSAJ9K42BStvWN9/JhlFReIFo/ryuFnIrVmuY=;
        b=loTQYR1zv82q/uTm4zloraSwm74kPjGN9Zjf08mn1034yITIN/V4uteBrJUB/ftfem
         qCg5wY63zwsGNuuEUMbDHbdCo91xD/GniwH3Y1WaY0sbgnVY9YoXnsS4lYwYKZCux35N
         PcbJJuDMD0hMMxZmgNVQBvKH2dWzAc3zqp47khrTRUHXK+sPmiG2Do3nbra785XOOTaA
         /cKVbmPRLwOOM8Pe6UxR7GsvqOrl+Og+krbUtVgb4IyrxyYWoxcPnM65uSYMfHQlvii1
         tQy2A2QgMyEjXn9N/i446urBrQ88c+z5Gh/TqYgprvsaHJkuW6qf4iYsnh8MJP43xv0+
         oFwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yl3cr9TSAJ9K42BStvWN9/JhlFReIFo/ryuFnIrVmuY=;
        b=EiulIFB2g7rEUSAhBwGge2w3tUSAlmCwHkEZhQ11ZYPjmqO+OxE7mQOPdQ9JXtlLuC
         b1BKI21UhfX7lWCPRwTCOYMhEUewxHrISHFQMH+5QarcTZmU+pXXAblXbmLa9BnJ8Qho
         NKGXZ+vsg2DRvuzqHPxLyPTI8EdK2NxX2gjH+NCWL1/u6zIlgXt12c9k2U4+dU6pvGzS
         yvF3zGrUWu3v7ptja4nICY0sdM850qqDh2Kz4eWNMFH0X33ybLuemmpmj0N5mGv06VUO
         AYBHGnxEVei7uaVc6uASbDpgMoa/+Dbtdg3o+xVs7MNK0EKfsIqfDGOVxuDLIrmxg5g3
         XSCA==
X-Gm-Message-State: AOAM5324aLs0HjtsKAUd0QkcbDZKEBDsEYYbFnr8AsLPrwY4gnWmSxwH
	+MClvpQoXE6vM5z1Y0f4+D1jh++GtEjf61TX
X-Google-Smtp-Source: ABdhPJyXnFi30TaP8EbXRulmNQWmgQ7CqlO/9p5mX1BM2WF897KpFUjwouWnAFK/e995WfvGCS5/bQ==
X-Received: by 2002:a17:906:32cf:: with SMTP id k15mr3167443ejk.68.1630742428925;
        Sat, 04 Sep 2021 01:00:28 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net (94.105.103.227.dyn.edpnet.net. [94.105.103.227])
        by smtp.gmail.com with ESMTPSA id bj21sm679749ejb.42.2021.09.04.01.00.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Sep 2021 01:00:28 -0700 (PDT)
To: Mat Martineau <mathew.j.martineau@linux.intel.com>,
 Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
References: <cover.1630595171.git.pabeni@redhat.com>
 <319eb0-91a3-fceb-d780-2e7f96ca4232@linux.intel.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Re: [PATCH v2 mptcp-next 0/4] mptcp: just another xmit path refactor
Message-ID: <b0118a14-7f8f-c770-aa2e-51e14e3a66ab@tessares.net>
Date: Sat, 4 Sep 2021 10:00:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <319eb0-91a3-fceb-d780-2e7f96ca4232@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit

Hi Paolo, Mat,

On 03/09/2021 22:11, Mat Martineau wrote:
> On Thu, 2 Sep 2021, Paolo Abeni wrote:
> 
>> Eric want to revert the tcp_tx_skb_cache. MPTCP relies on it
>> for skb allocation. Before the revert we need to refactor our
>> xmit path.
>>
>> Patch 1 exposes some needed helpers (endorsed by Eric)
>> Patch 2 contains the nasty new code
>> Patch 3 revert some core TCP changes not needed anymore
>> and patch 4 is Eric's revert.
>>
>> This iteration should hopefully solve the OoB issues I observed with
>> the previous attempt, changes documented in patch 2.
>>
>> Eric Dumazet (1):
>>  tcp: remove sk_{tr}x_skb_cache
>>
>> Paolo Abeni (3):
>>  tcp: expose the tcp_mark_push() and skb_entail() helpers
>>  mptcp: stop relaying on tcp_tx_skb_cache.
>>  Partially revert "tcp: factor out tcp_build_frag()"
>>
>> Documentation/networking/ip-sysctl.rst |   8 --
>> include/net/sock.h                     |  19 ----
>> include/net/tcp.h                      |   4 +-
>> net/ipv4/af_inet.c                     |   4 -
>> net/ipv4/sysctl_net_ipv4.c             |  12 --
>> net/ipv4/tcp.c                         | 147 +++++++++----------------
>> net/ipv4/tcp_ipv4.c                    |   6 -
>> net/ipv6/tcp_ipv6.c                    |   6 -
>> net/mptcp/protocol.c                   | 132 +++++++++++++---------
>> 9 files changed, 132 insertions(+), 206 deletions(-)
>>
>> -- 
>> 2.26.3

Thank you for the patches and the reviews

> It's ok to apply the series to the export branch. Before we upstream it,
> can Paolo send a squash-to patch for #2 that removes the
> WARN_ON_ONCE(!mpext)?
> 
> Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

These patches are now in our tree -- features for net-next -- with:

- Mat's RvB tag on patch 2/4
- Mat's Ack on patches 1/4 and 3-4/4
- Paolo's Ack on patch 4/4
- fixed a typo and removed dot in the title of patch 2/4
- a small checkpatch fix in patch 2/4: Unnecessary parentheses
- without checkpatch fixes in patch 3/4: bring back old and "non
compliant" code in TCP
- (I hope it is OK) reduce commit SHA lengths in patch 4/4's message to
fix checkpatch errors.

Commits:

- ef9706ecd17e: tcp: expose the tcp_mark_push() and skb_entail() helpers

- 0ed0c4ad3483: mptcp: stop relying on tcp_tx_skb_cache

- ee51bf92cdcc: Partially revert "tcp: factor out tcp_build_frag()"

- ead8eb1fc223: tcp: remove sk_{tr}x_skb_cache
- Results: 7755d2ada382..d692ad305b2a

WARN_ON_ONCE(!mpext):

- 618f6578f614: mptcp: remove no longer needed check
- Results: d692ad305b2a..7a2d18a25e65

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20210904T080009
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export/20210904T080009

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
