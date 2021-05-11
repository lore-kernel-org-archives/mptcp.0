Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FF071
	for <mptcp@lists.linux.dev>; Tue, 11 May 2021 16:17:56 +0000 (UTC)
IronPort-SDR: m4va70U90ogMXvSylQlT5VcQkeaAk9Ttx84a+iaWQREEzzruVCyxfRqKkfxcIwItXRE9jdSxm+
 ILDo/GD4otcw==
X-IronPort-AV: E=McAfee;i="6200,9189,9981"; a="263414050"
X-IronPort-AV: E=Sophos;i="5.82,291,1613462400"; 
   d="scan'208";a="263414050"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2021 09:17:53 -0700
IronPort-SDR: 0XEmA9qfkOOv5KrybAqmasZ9nIH9LuSqyBooO1myD0wwiY1kadczBv0J3IiFq+lcWymMC/NVu3
 eyQDMAF3cfLQ==
X-IronPort-AV: E=Sophos;i="5.82,291,1613462400"; 
   d="scan'208";a="408858875"
Received: from kcolwell-mobl.amr.corp.intel.com ([10.251.1.71])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2021 09:17:53 -0700
Date: Tue, 11 May 2021 09:17:52 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
    Jakub Kicinski <kuba@kernel.org>, mptcp@lists.linux.dev, 
    Maxim Galaganov <max@internet.ru>
Subject: Re: [PATCH net] mptcp: fix data stream corruption
In-Reply-To: <95cee926051dae0afe4d39072f446e1cad17008a.1620720059.git.pabeni@redhat.com>
Message-ID: <c7b744f0-31e3-c727-ce49-a35613b71a6@linux.intel.com>
References: <95cee926051dae0afe4d39072f446e1cad17008a.1620720059.git.pabeni@redhat.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 11 May 2021, Paolo Abeni wrote:

> Maxim reported several issues when forcing a TCP transparent proxy
> to use the MPTCP protocol for the inbound connections. He also
> provided a clean reproducer.
>
> The problem boils down to 'mptcp_frag_can_collapse_to()' assuming
> that only MPTCP will use the given page_frag.
>
> If others - e.g. the plain TCP protocol - allocate page fragments,
> we can end-up re-using already allocated memory for mptcp_data_frag.
>
> Fix the issue ensuring that the to-be-expanded data fragment is
> located at the current page frag end.
>
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/178
> Reported-and-tested-by: Maxim Galaganov <max@internet.ru>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> net/mptcp/protocol.c | 6 ++++++
> 1 file changed, 6 insertions(+)

Hi Paolo -

Should this also have a:

Fixes: 18b683bff89d ("mptcp: queue data for mptcp level retransmission")

?


-Mat


>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 29a2d690d8d5..2d21a4793d9d 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -879,12 +879,18 @@ static bool mptcp_skb_can_collapse_to(u64 write_seq,
> 	       !mpext->frozen;
> }
>
> +/* we can append data to the given data frag if:
> + * - there is space available in the backing page_frag
> + * - the data frag tail matches the current page_frag free offset
> + * - the data frag end sequence number matches the current write seq
> + */
> static bool mptcp_frag_can_collapse_to(const struct mptcp_sock *msk,
> 				       const struct page_frag *pfrag,
> 				       const struct mptcp_data_frag *df)
> {
> 	return df && pfrag->page == df->page &&
> 		pfrag->size - pfrag->offset > 0 &&
> +		pfrag->offset == (df->offset + df->data_len) &&
> 		df->data_seq + df->data_len == msk->write_seq;
> }
>
> -- 
> 2.26.2
>
>
>

--
Mat Martineau
Intel
