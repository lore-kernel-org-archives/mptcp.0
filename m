Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F8F70
	for <mptcp@lists.linux.dev>; Wed, 12 May 2021 19:51:39 +0000 (UTC)
IronPort-SDR: Guep2HDbKWL1MdCSndwV/I39HxR5qaFtqNlSBj+0agD+ibR9y3rEvTh/A8F99IZT1m3QS2Ujo/
 pMW3af38LENA==
X-IronPort-AV: E=McAfee;i="6200,9189,9982"; a="187217248"
X-IronPort-AV: E=Sophos;i="5.82,295,1613462400"; 
   d="scan'208";a="187217248"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2021 12:51:38 -0700
IronPort-SDR: AQ5QAm9sjDagCIT9FVhqb7mYa+RnqvU3j/nkBjPGSVjzQ3a210CAEMDmR4Wkm+cbZ//oJW9C0b
 Kp7gVacNc4Xw==
X-IronPort-AV: E=Sophos;i="5.82,295,1613462400"; 
   d="scan'208";a="392882583"
Received: from bsirota-mobl.amr.corp.intel.com ([10.209.18.175])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2021 12:51:38 -0700
Date: Wed, 12 May 2021 12:51:38 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliangtang@gmail.com>, 
    Matthieu Baerts <matthieu.baerts@tessares.net>
cc: mptcp@lists.linux.dev
Subject: Re: [MPTCP][PATCH mptcp-next] Squash to "mptcp: receive checksum
 for MP_CAPABLE with data"
In-Reply-To: <894be7ae85244360c4dd5a250043086d3bbc8826.1620792920.git.geliangtang@gmail.com>
Message-ID: <539353c-ea21-ea0-ef57-a46ac03d7b70@linux.intel.com>
References: <894be7ae85244360c4dd5a250043086d3bbc8826.1620792920.git.geliangtang@gmail.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 12 May 2021, Geliang Tang wrote:

> Drop the csum_replace2 trunk as Mat suggested.
>
> mptcp_make_csum() hasn't been called yet so the pseudoheader has not been
> included in the checksum.
>
> Signed-off-by: Geliang Tang <geliangtang@gmail.com>
> ---
> Apply the patch (Squash to "mptcp: generate the data checksum") first.
> ---
> net/mptcp/options.c | 5 -----
> 1 file changed, 5 deletions(-)

Thanks Geliang.

Matthieu, all the pending squash-to patches from Geliang are ok to merge.


-Mat


>
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index cce90c16e47d..6b737ba1f941 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -547,11 +547,6 @@ static void mptcp_write_data_fin(struct mptcp_subflow_context *subflow,
> 		 */
> 		ext->data_fin = 1;
> 		ext->data_len++;
> -
> -		/* the pseudo header has changed, update the csum accordingly */
> -		if (ext->csum_reqd)
> -			csum_replace2(&ext->csum, htons(ext->data_len - 1),
> -				      htons(ext->data_len));
> 	}
> }
>
> -- 
> 2.31.1
>
>
>

--
Mat Martineau
Intel
