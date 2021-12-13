Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9C42C80
	for <mptcp@lists.linux.dev>; Mon, 13 Dec 2021 23:15:22 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="226128842"
X-IronPort-AV: E=Sophos;i="5.88,203,1635231600"; 
   d="scan'208";a="226128842"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 15:15:21 -0800
X-IronPort-AV: E=Sophos;i="5.88,203,1635231600"; 
   d="scan'208";a="517971564"
Received: from luisdsan-mobl.amr.corp.intel.com ([10.209.68.26])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 15:15:21 -0800
Date: Mon, 13 Dec 2021 15:15:20 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: =?ISO-8859-7?Q?J=E5an_Sacren?= <sakiwit@gmail.com>
cc: matthieu.baerts@tessares.net, mptcp@lists.linux.dev
Subject: Re: [PATCH v2 net-next] net: mptcp: clean up harmless false
 expressions
In-Reply-To: <20211210230245.342764-1-sakiwit@gmail.com>
Message-ID: <934d348a-d843-6f80-c4f6-70e0745e574@linux.intel.com>
References: <20211210230245.342764-1-sakiwit@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="0-1960849817-1639434947=:11200"
Content-ID: <10c15c9e-acd0-a196-1d8a-32c0f2f3895@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-1960849817-1639434947=:11200
Content-Type: text/plain; CHARSET=ISO-8859-7; format=flowed
Content-Transfer-Encoding: 8BIT
Content-ID: <dfca21a5-322-6032-7577-86122a75603b@linux.intel.com>

On Fri, 10 Dec 2021, Jåan Sacren wrote:

> From: Jean Sacren <sakiwit@gmail.com>
>
> entry->addr.id is u8 with a range from 0 to 255 and MAX_ADDR_ID is 255.
> We should drop both false expressions of (entry->addr.id > MAX_ADDR_ID).
>
> We should also remove the obsolete parentheses in the first if branch.
>
> Use U8_MAX for MAX_ADDR_ID and add a comment to show the link to
> mptcp_addr_info.id as suggested by Mr. Matthieu Baerts.
>
> Signed-off-by: Jean Sacren <sakiwit@gmail.com>
> ---
> v2:
> (1) Use U8_MAX for MAX_ADDR_ID.
> (2) Add a comment for link to mptcp_addr_info.id.
>    Thank you, Mr. Matthieu Baerts!
> net/mptcp/pm_netlink.c | 8 ++++----
> 1 file changed, 4 insertions(+), 4 deletions(-)

Looks good to me:

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>



>
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 4ff8d55cbe82..35cc4c64c06c 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -38,7 +38,8 @@ struct mptcp_pm_add_entry {
> 	u8			retrans_times;
> };
>
> -#define MAX_ADDR_ID		255
> +/* max value of mptcp_addr_info.id */
> +#define MAX_ADDR_ID		U8_MAX
> #define BITMAP_SZ DIV_ROUND_UP(MAX_ADDR_ID + 1, BITS_PER_LONG)
>
> struct pm_nl_pernet {
> @@ -822,14 +823,13 @@ static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
> 		entry->addr.id = find_next_zero_bit(pernet->id_bitmap,
> 						    MAX_ADDR_ID + 1,
> 						    pernet->next_id);
> -		if ((!entry->addr.id || entry->addr.id > MAX_ADDR_ID) &&
> -		    pernet->next_id != 1) {
> +		if (!entry->addr.id && pernet->next_id != 1) {
> 			pernet->next_id = 1;
> 			goto find_next;
> 		}
> 	}
>
> -	if (!entry->addr.id || entry->addr.id > MAX_ADDR_ID)
> +	if (!entry->addr.id)
> 		goto out;
>
> 	__set_bit(entry->addr.id, pernet->id_bitmap);
>

--
Mat Martineau
Intel
--0-1960849817-1639434947=:11200--
