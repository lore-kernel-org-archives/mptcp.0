Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBAC7E
	for <mptcp@lists.linux.dev>; Thu,  3 Mar 2022 15:52:44 +0000 (UTC)
Received: by mail-ej1-f51.google.com with SMTP id kt27so11691614ejb.0
        for <mptcp@lists.linux.dev>; Thu, 03 Mar 2022 07:52:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=PRUa/CcA7qIAGUTvPRvMEcK61UrxpmuoExUqXMBRaTY=;
        b=3UPGZc38Qzs428IxZPqwHNQ6vo4FS1M6Uo1lDSv0iwcsUrEnPOgS4LUO4m3ejnm57c
         i/7RJV+VmD2YNkF8esrLHT3LfeYQ7k52y7ZB4tdNIW97eAxu9kj43GPOrLLoqUyfiWG6
         BDzWzjVMSWbMhGbXfNK3gStNpKFQd2suimmUGjUvwcHbmtmaINPmXdIxjeARDzjjkFaJ
         rECjmMWly44C9ZjZD6XlxnpfdvXEQWU4GTngnqeAbCm/8Aq3OCWJATAi7qAtCIxKUJ+K
         cuQQ/PZR60ANZ7QQ8pA4E6NADUIuTKsnWLSiGDXdvQHF1f3OwkYS4y713wtZdBwiODAM
         2FAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=PRUa/CcA7qIAGUTvPRvMEcK61UrxpmuoExUqXMBRaTY=;
        b=dY6FHMReadLpC93aWE1nqXSvVgNoIUYy0D3MJ8ExR9P2y1qsNPa2DCfVWTqTIsf/3z
         qrwbAxYc4UC/VAb0t2gjawGal200XYebxrEgKnjk7ODX0HB6/WMDiGOvBDJarjFWdMBF
         OFLm983MR9kuyU/s1/g4Ou3SgjuqgAAyUNmeBzLo6oXlLZ/IGaTOMF+sLFOWmVE2xacG
         5a3km8Tm2rn9Ac2CxhwYVWNFCoH40f/Wtq77LB15xPdwe8FHOU/t3QZoYfn8MYnQbGqM
         TouYnLUzT1Xwj4UVYSvN+B72ThsYNJbYQcaMGrQQd+Hd7cy+n7qw+hSy67EG4t8kfhYB
         oM6w==
X-Gm-Message-State: AOAM530Fz/fQ2vSBgP/bAj7j543sdRsdbsgZH0HlKo18KRsO2VlvCxVz
	g7ckO9w53xCnriEkmEgXWPBfgi5z+VtVjjox
X-Google-Smtp-Source: ABdhPJyHcx3wXBPYuxkn4K+U/GQWGA3FM9+Nx/A+OFX81vnO2M2P0LUq8dV3H4syMCbjP2Sjegsv3w==
X-Received: by 2002:a17:907:16a6:b0:6da:6543:3f9e with SMTP id hc38-20020a17090716a600b006da65433f9emr6571927ejc.156.1646322762343;
        Thu, 03 Mar 2022 07:52:42 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:9692:b15:c6e7:1c2e? ([2a02:578:8593:1200:9692:b15:c6e7:1c2e])
        by smtp.gmail.com with ESMTPSA id n3-20020a1709061d0300b006da94efcc7esm612562ejh.204.2022.03.03.07.52.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Mar 2022 07:52:42 -0800 (PST)
Message-ID: <385b4470-0d2b-e084-c753-d7af0262e3eb@tessares.net>
Date: Thu, 3 Mar 2022 16:52:41 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH RESEND mptcp-next v5 2/3] bpf: implement bpf_mptcp_sock()
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1646320786.git.geliang.tang@suse.com>
 <cb3f55a9c5ef9b89ed5da8949192077fb72f275b.1646320786.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <cb3f55a9c5ef9b89ed5da8949192077fb72f275b.1646320786.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 03/03/2022 16:22, Geliang Tang wrote:
> This patch implemented the function bpf_mptcp_sock(). Defined a new bpf_id
> BTF_SOCK_TYPE_MPTCP, and added a new helper bpf_mptcp_sock_from_subflow()
> to get struct bpf_mptcp_sock from a given subflow socket.

(...)

> diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
> index 2e42a95d1206..e3213818c45b 100644
> --- a/net/mptcp/bpf.c
> +++ b/net/mptcp/bpf.c
> @@ -25,3 +25,18 @@ bool bpf_mptcp_sock_is_valid_access(int off, int size, enum bpf_access_type type
>  		return size == sizeof(__u32);
>  	}
>  }
> +
> +struct bpf_mptcp_sock *bpf_mptcp_sock_from_subflow(struct sock *sk)
> +{
> +	if (sk && sk_fullsock(sk) && sk->sk_protocol == IPPROTO_TCP && sk_is_mptcp(sk)) {
> +		struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
> +		struct mptcp_sock *msk = mptcp_sk(subflow->conn);
> +		struct bpf_mptcp_sock *bpf_msk;
> +
> +		bpf_msk = (struct bpf_mptcp_sock *)subflow->conn;
> +		bpf_msk->token = msk->token;
> +		return bpf_msk;

If I'm not mistaken, you are still using this definition of the
bpf_mptcp_sock structure:

  struct bpf_mptcp_sock {
      __u32 token;
  };

Is that correct?

If yes, what you are doing above doesn't seem correct: you cannot cast
mptcp_sock into this structure. Or did I miss something?


In other words, I don't think you should return a bpf_mptcp_sock
structure here but an mptcp_sock one: not a specific one for BPF. By
doing that, we will be able to access all items of the MPTCP socket, not
just the token you copy here in a new structure.
If we can access the mptcp_sock structure, we no longer need to convert
anything and copy only some selected fields from what I understand.

It would then be similar to bpf_skc_to_tcp_sock() returning a "struct
tcp_sock" pointer where it is possible to access all fields from it, not
only what has been copied.

Do you see what I mean? :)

BTW it might be better to have a squash-to patch for "bpf: add
'bpf_mptcp_sock' structure and helper" which would also modify the
commit title and message! From what I understood from Alexei,
'bpf_mptcp_sock' structure is no longer needed.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
