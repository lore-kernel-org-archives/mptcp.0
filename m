Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A57570
	for <mptcp@lists.linux.dev>; Tue, 11 May 2021 00:46:00 +0000 (UTC)
IronPort-SDR: AG6di8nwfm23eB+aOvJFa9jO3SngwT5UZ3rPLcsH7s+Xt6mfI8t5r5wFzKQdpdyS/SjqFey0bp
 z47hal+gIJ+w==
X-IronPort-AV: E=McAfee;i="6200,9189,9980"; a="220274665"
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; 
   d="scan'208";a="220274665"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2021 17:45:56 -0700
IronPort-SDR: Kju6WOes43WWeYkn3zl+cuqilwIFFYijB0/j6RllhYQyDIVCR6GR2biV2N2VotH7gcaf3F7PwH
 zxkPVBbp6LZw==
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; 
   d="scan'208";a="470959055"
Received: from akalita-mobl1.amr.corp.intel.com ([10.209.125.201])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2021 17:45:51 -0700
Date: Mon, 10 May 2021 17:45:48 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliangtang@gmail.com>
cc: mptcp@lists.linux.dev
Subject: Re: [MPTCP][PATCH mptcp-next] Squash to "mptcp: generate the data
 checksum"
In-Reply-To: <694573465901ea0fc5318b379af75f5287a4f77f.1620360953.git.geliangtang@gmail.com>
Message-ID: <e3d8cbf6-4de3-40da-5442-49d5265f9f5@linux.intel.com>
References: <694573465901ea0fc5318b379af75f5287a4f77f.1620360953.git.geliangtang@gmail.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 7 May 2021, Geliang Tang wrote:

> Move the csum_replace2 trunk into the later patch "mptcp: receive
> checksum for MP_CAPABLE with data".
>
> Signed-off-by: Geliang Tang <geliangtang@gmail.com>
> ---
> net/mptcp/options.c | 3 ---
> 1 file changed, 3 deletions(-)
>
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index beac01f58cba..99fc21406168 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -519,9 +519,6 @@ static void mptcp_write_data_fin(struct mptcp_subflow_context *subflow,
> 		 */
> 		ext->data_fin = 1;
> 		ext->data_len++;
> -
> -		/* the pseudo header has changed, update the csum accordingly */
> -		csum_replace2(&ext->csum, htons(ext->data_len - 1), htons(ext->data_len));

The commit message above says this is is moved to another patch, but the 
posted squash-to patch for "mptcp: receive checksum for MP_CAPABLE with 
data" doesn't add this functionality back. Is a hunk or another squash-to 
patch missing?


Thanks,

--
Mat Martineau
Intel
