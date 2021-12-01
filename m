Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5F568
	for <mptcp@lists.linux.dev>; Wed,  1 Dec 2021 02:08:32 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10184"; a="233866996"
X-IronPort-AV: E=Sophos;i="5.87,277,1631602800"; 
   d="scan'208";a="233866996"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2021 18:08:25 -0800
X-IronPort-AV: E=Sophos;i="5.87,277,1631602800"; 
   d="scan'208";a="500034337"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2) ([10.212.229.172])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2021 18:08:25 -0800
Date: Tue, 30 Nov 2021 18:08:25 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-net] mptcp: add missing documented NL params
In-Reply-To: <20211130162026.1455269-1-matthieu.baerts@tessares.net>
Message-ID: <4a76c2f6-83e6-8fdd-cbdc-68938a20bc4c@linux.intel.com>
References: <20211130162026.1455269-1-matthieu.baerts@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 30 Nov 2021, Matthieu Baerts wrote:

> 'loc_id' and 'rem_id' are set in all events linked to subflows but those
> were missing in the events description in the comments.
>
> Fixes: b911c97c7dc7 ("mptcp: add netlink event support")
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> ---
> include/uapi/linux/mptcp.h | 18 ++++++++++--------
> 1 file changed, 10 insertions(+), 8 deletions(-)
>

Thanks for the fix Matthieu, looks good to me.

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

> diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
> index c8cc46f80a16..f106a3941cdf 100644
> --- a/include/uapi/linux/mptcp.h
> +++ b/include/uapi/linux/mptcp.h
> @@ -136,19 +136,21 @@ struct mptcp_info {
>  * MPTCP_EVENT_REMOVED: token, rem_id
>  * An address has been lost by the peer.
>  *
> - * MPTCP_EVENT_SUB_ESTABLISHED: token, family, saddr4 | saddr6,
> - *                              daddr4 | daddr6, sport, dport, backup,
> - *                              if_idx [, error]
> + * MPTCP_EVENT_SUB_ESTABLISHED: token, family, loc_id, rem_id,
> + *                              saddr4 | saddr6, daddr4 | daddr6, sport,
> + *                              dport, backup, if_idx [, error]
>  * A new subflow has been established. 'error' should not be set.
>  *
> - * MPTCP_EVENT_SUB_CLOSED: token, family, saddr4 | saddr6, daddr4 | daddr6,
> - *                         sport, dport, backup, if_idx [, error]
> + * MPTCP_EVENT_SUB_CLOSED: token, family, loc_id, rem_id, saddr4 | saddr6,
> + *                         daddr4 | daddr6, sport, dport, backup, if_idx
> + *                         [, error]
>  * A subflow has been closed. An error (copy of sk_err) could be set if an
>  * error has been detected for this subflow.
>  *
> - * MPTCP_EVENT_SUB_PRIORITY: token, family, saddr4 | saddr6, daddr4 | daddr6,
> - *                           sport, dport, backup, if_idx [, error]
> - *       The priority of a subflow has changed. 'error' should not be set.
> + * MPTCP_EVENT_SUB_PRIORITY: token, family, loc_id, rem_id, saddr4 | saddr6,
> + *                           daddr4 | daddr6, sport, dport, backup, if_idx
> + *                           [, error]
> + * The priority of a subflow has changed. 'error' should not be set.
>  */
> enum mptcp_event_type {
> 	MPTCP_EVENT_UNSPEC = 0,
> -- 
> 2.32.0

--
Mat Martineau
Intel
