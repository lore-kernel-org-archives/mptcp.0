Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C3B71
	for <mptcp@lists.linux.dev>; Sat,  8 May 2021 00:54:12 +0000 (UTC)
IronPort-SDR: MXV1g9Yzzf94fGo1cZODQChIK2qEGDfqUVZ5cGDBwZLbJKUGN/tG/S2Y3cLy9dwmZvKeBSC/0B
 SuW/HrcqEICg==
X-IronPort-AV: E=McAfee;i="6200,9189,9977"; a="198924062"
X-IronPort-AV: E=Sophos;i="5.82,282,1613462400"; 
   d="scan'208";a="198924062"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2021 17:54:11 -0700
IronPort-SDR: 0bGCtMy549qI0rXrWHrSbuu3UjUdCpW2VSp1JuqF/MNiArfMixGpEyZm3ZJQ/BjBSw1q4/NLIY
 dO7fJ5vrlRYg==
X-IronPort-AV: E=Sophos;i="5.82,282,1613462400"; 
   d="scan'208";a="435153566"
Received: from magalleg-mobl.amr.corp.intel.com ([10.209.84.24])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2021 17:54:11 -0700
Date: Fri, 7 May 2021 17:54:11 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliangtang@gmail.com>
cc: mptcp@lists.linux.dev
Subject: Re: [MPTCP][PATCH mptcp-next 3/3] mptcp: send out MP_FAIL when data
 checksum fail
In-Reply-To: <f46dabaf1055b87b5613b126372d9e506c178264.1620282930.git.geliangtang@gmail.com>
Message-ID: <8aadaeb7-60e6-83ab-d6ce-1ca1579f9e94@linux.intel.com>
References: <cover.1620282929.git.geliangtang@gmail.com> <f158cbfcb748b9b6792d9b316b8fa810e5cb044a.1620282929.git.geliangtang@gmail.com> <bbdc6ded86ae034f443853b6e207aea2b3b2c519.1620282929.git.geliangtang@gmail.com>
 <f46dabaf1055b87b5613b126372d9e506c178264.1620282930.git.geliangtang@gmail.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 6 May 2021, Geliang Tang wrote:

> When a bad checksum is detected, send out the MP_FAIL suboption.
>
> Signed-off-by: Geliang Tang <geliangtang@gmail.com>
> ---
> net/mptcp/subflow.c | 2 ++
> 1 file changed, 2 insertions(+)
>
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 659b8842ae3b..efd84ff61015 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -906,6 +906,8 @@ static enum mapping_status validate_data_csum(struct sock *ssk, struct sk_buff *
> 	csum = csum_partial(&header, sizeof(header), subflow->map_data_csum);
> 	if (unlikely(csum_fold(csum))) {
> 		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_DSSCSUMERR);
> +		subflow->send_mp_fail = 1;
> +		subflow->fail_seq = subflow->map_seq;

map_seq is the sequence number of the last good data *received* by this 
peer, but fail_seq will be used to discard data *sent* by this peer. So I 
think fail_seq needs to be based on the sequence number for outgoing data 
on this subflow? I admit the RFC has me confused here. If MP_FAIL is 
implemented on the multipath-tcp.org kernel it might be helpful to see how 
it is used there.


> 		return subflow->mp_join ? MAPPING_INVALID : MAPPING_DUMMY;
> 	}
>
> -- 
> 2.31.1
>
>
>

--
Mat Martineau
Intel
