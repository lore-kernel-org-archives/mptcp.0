Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E086F
	for <mptcp@lists.linux.dev>; Mon, 22 Mar 2021 21:56:46 +0000 (UTC)
IronPort-SDR: 1ykaxlDurVtCGAXRzEZ4ez02POcmqmJ+0XuxeMei5kCVsnqn+1Hjwv9r4gb4y6X7W5z2zyxDm3
 CuFqlls0pq0A==
X-IronPort-AV: E=McAfee;i="6000,8403,9931"; a="210430008"
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; 
   d="scan'208";a="210430008"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2021 14:56:40 -0700
IronPort-SDR: XtDGWQfDYckNwZjfsiKyAzXtSPHc5INg/OQB7TNuyIBfCPBRGyVWzufJvn3cC59O+eXKp1qg+I
 KmZz6kkOZs/w==
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; 
   d="scan'208";a="451880954"
Received: from shahinam-mobl2.amr.corp.intel.com ([10.252.128.161])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2021 14:56:35 -0700
Date: Mon, 22 Mar 2021 14:56:34 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
cc: mptcp@lists.linux.dev, mptcp@lists.01.org, 
    Geliang Tang <geliangtang@gmail.com>
Subject: Re: [PATCH mptcp-next 3/3] Squash to "mptcp: drop
 MPTCP_ADDR_IPVERSION_4/6"
In-Reply-To: <20210322162132.2471823-3-matthieu.baerts@tessares.net>
Message-ID: <502b4037-3ca0-1fb9-8985-5fbc7fdb2e2@linux.intel.com>
References: <20210322162132.2471823-1-matthieu.baerts@tessares.net> <20210322162132.2471823-3-matthieu.baerts@tessares.net>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed


On Mon, 22 Mar 2021, Matthieu Baerts wrote:

> Fix issues reported by sparse because we are doing non explicit casting
> from __be16 to integer.
>
>  net/mptcp/options.c:604:24: warning: restricted __be16 degrades to integer
>  net/mptcp/options.c:605:24: warning: restricted __be16 degrades to integer
>
> Before the mentioned commit, we were using port in u16 given in argument
> of add_addr_generate_hmac function, everything was OK.
>
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> ---
> net/mptcp/options.c | 5 +++--
> 1 file changed, 3 insertions(+), 2 deletions(-)

I think the subject line is incorrect on this one (it applies cleanly to 
"mptcp: unify add_addr(6)_generate_hmac" instead), but other than that all 
three patches look good to squash. Thanks!

Mat


>
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 071b446aa2c9..d9e5f864d774 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -586,6 +586,7 @@ static bool mptcp_established_options_dss(struct sock *sk, struct sk_buff *skb,
> static u64 add_addr_generate_hmac(u64 key1, u64 key2,
> 				  struct mptcp_addr_info *addr)
> {
> +	u16 port = be16_to_cpu(addr->port);
> 	u8 hmac[SHA256_DIGEST_SIZE];
> 	u8 msg[19];
> 	int i = 0;
> @@ -601,8 +602,8 @@ static u64 add_addr_generate_hmac(u64 key1, u64 key2,
> 		i += 16;
> 	}
> #endif
> -	msg[i++] = addr->port >> 8;
> -	msg[i++] = addr->port & 0xFF;
> +	msg[i++] = port >> 8;
> +	msg[i++] = port & 0xFF;
>
> 	mptcp_crypto_hmac_sha(key1, key2, msg, i, hmac);
>
> -- 
> 2.30.2
>
>
>

--
Mat Martineau
Intel
