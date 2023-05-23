Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9A51F93C
	for <mptcp@lists.linux.dev>; Tue, 23 May 2023 18:49:13 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1q1X4J-0004u0-RW; Tue, 23 May 2023 20:49:11 +0200
Date: Tue, 23 May 2023 20:49:11 +0200
From: Florian Westphal <fw@strlen.de>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH v3 mptcp-next 4/6] mptcp: track some aggregate data
 counters.
Message-ID: <20230523184911.GC17561@breakpoint.cc>
References: <cover.1684863309.git.pabeni@redhat.com>
 <6c8b8ab79ee6526dff0cd3240e35e2e82c300a5d.1684863309.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c8b8ab79ee6526dff0cd3240e35e2e82c300a5d.1684863309.git.pabeni@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Paolo Abeni <pabeni@redhat.com> wrote:
> Currently there are no data transfer counters accounting for all
> the subflows used by a given MPTCP socket. The user-space can compute
> such figures aggregating the subflow info, but that is inaccurate
> if any subflow is closed before the MPTCP socket itself.
> 
> Add the new counters in the MPTCP socket itself and expose them
> via the existing diag and sockopt. While touching mptcp_diag_fill_info(),
> acquire the relevant locks before fetching the msk data, to ensure
> better data consistency
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
>  include/uapi/linux/mptcp.h |  5 +++++
>  net/mptcp/options.c        | 10 ++++++++--
>  net/mptcp/protocol.c       | 12 +++++++++++-
>  net/mptcp/protocol.h       |  4 ++++
>  net/mptcp/sockopt.c        | 22 +++++++++++++++++-----
>  5 files changed, 45 insertions(+), 8 deletions(-)
> 
> diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
> index f4f42d88e58b..ac469625affd 100644
> --- a/include/uapi/linux/mptcp.h
> +++ b/include/uapi/linux/mptcp.h
> @@ -124,6 +124,11 @@ struct mptcp_info {
>  	__u8	mptcpi_local_addr_used;
>  	__u8	mptcpi_local_addr_max;
>  	__u8	mptcpi_csum_enabled;
> +	__u32	mptcpi_retransmits;
> +	__u64	mptcpi_bytes_retrans;
> +	__u64	mptcpi_bytes_sent;
> +	__u64	mptcpi_bytes_received;
> +	__u64	mptcpi_bytes_acked;

__aligned_u64 is preferred for uapi.
