Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024771872
	for <mptcp@lists.linux.dev>; Thu,  6 Jul 2023 08:21:51 +0000 (UTC)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-977e0fbd742so49113366b.2
        for <mptcp@lists.linux.dev>; Thu, 06 Jul 2023 01:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1688631710; x=1691223710;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xrkIvyXhCXMy3E4VUJzrcYyXgFi89ekolNIFJqpyKTw=;
        b=qwT4LGuG4UTR8nPCHVrs2AqXFG8BS1ILDA5NNc+8I8N3zVa39hjfbbzqMiRHIM15SW
         DpmrrBIHWR0dL+G669h6kC99Vt+4/PDUMYKKQJnhHxATMPJFChPOSG/H0TTF2W+PBADj
         52F58HjxR0yCGNxnUGyFDpAGRVazJaEZZov1gkFemwTnrPpou3Zy/LpR3vhcqxLEmvNn
         K6mBi1cbM/sawk68owr0j30uHc5fFMhR62lCJJlvaSe+CYvCKVrSrUkd3Va1iXfsCsD6
         1sfcgIll17r++GKWs028K8ivSjRoVOUrCwISwPJR1359g6PIZkDPZJ/lofd1+f6g8/Ej
         cVEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688631710; x=1691223710;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xrkIvyXhCXMy3E4VUJzrcYyXgFi89ekolNIFJqpyKTw=;
        b=g0bp2AFqyWt03tJjRHo+CVBA7TpnQafyABBPl5wO0Lf2NiGJjZj2pn+Ly6rCsFXWyX
         +1TCNvgWX0CYuH8UBD19QXFzSFqwmeX+T2S+NNOd2EPi2ij8Olpw8rX+a6pj+Ibh5Ux4
         GfWXWCsZ7g5CcAGj6GnOgNXLmcq3a7Trtxz9fKEayBsJGCiEtMpmiWmXPd+UuHYupyVd
         2NVyR8cBqAU8o+1VN1vUCVaBXe8OhKtYgRrN6KuPPB7Eg7z+g+Kec17OlJwZO0ZZNOUb
         1HlpTliI1VZB2h+A2R0mDCUXxeCQqGBpOk1QqEOuhstfArw84+bfil0SC5HnSf4I4ulH
         cZwg==
X-Gm-Message-State: ABy/qLa2SJ7wPdYqbg40y5lE1FIS/Pnlweoo9gO1zdVcopbDV0641eJP
	5Ax/Hd3L/BPgHxp/f6Ac9lUvuAmaJwz2d2sTXAw8JP6a
X-Google-Smtp-Source: APBJJlGJctF9nK855yWm6NKlpTglbqpfJ4UNvTANPe7DDrTsOw4PebWF3yyZeffian9scWSq9kX8bQ==
X-Received: by 2002:a17:907:8f03:b0:973:d1ce:dbe8 with SMTP id wg3-20020a1709078f0300b00973d1cedbe8mr678437ejc.46.1688631709801;
        Thu, 06 Jul 2023 01:21:49 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:7daa:6d50:9464:2ccc? ([2a02:578:8593:1200:7daa:6d50:9464:2ccc])
        by smtp.gmail.com with ESMTPSA id c22-20020a170906529600b00992f8110a2bsm498025ejm.150.2023.07.06.01.21.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jul 2023 01:21:49 -0700 (PDT)
Message-ID: <194f9db2-c5dc-d7b7-a237-5c458a028764@tessares.net>
Date: Thu, 6 Jul 2023 10:21:47 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [RFC bpf-next v2 8/8] selftests/bpf: Add mptcpify selftest
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
References: <cover.1688629124.git.geliang.tang@suse.com>
 <5c88e528d4be098c2fa73ba49bc1b20615b77a53.1688629124.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <5c88e528d4be098c2fa73ba49bc1b20615b77a53.1688629124.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

(without BPF ML not to disturb them for this detail)

On 06/07/2023 09:47, Geliang Tang wrote:
> This patch extends the MPTCP test base, add a selftest test_mptcpify()
> for the mptcpify case.
> 
> Open and load the mptcpify test prog to mptcpify the TCP sockets
> dynamically, then use start_server() and connect_to_fd() to create a
> TCP socket, but actually what's created is an MPTCP socket, which can
> be verified through the output of 'ss' command.
> 
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
>  .../testing/selftests/bpf/prog_tests/mptcp.c  | 91 +++++++++++++++++++
>  1 file changed, 91 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> index b2a833a900c2..de05140fe638 100644
> --- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
> +++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c

(...)

> +static int verify_mptcpify(void)
> +{
> +	char cmd[128];
> +	int err = 0;
> +
> +	snprintf(cmd, sizeof(cmd),
> +		 "ip netns exec %s ss -tOni | grep -q '%s'",
> +		 NS_TEST, "tcp-ulp-mptcp");
> +	if (!ASSERT_OK(system(cmd), "No tcp-ulp-mptcp found!"))
> +		err++;
> +
> +	snprintf(cmd, sizeof(cmd),
> +		 "ip netns exec %s nstat -asz %s | awk '%s' | grep -q '%s'",
> +		 NS_TEST, "MPTcpExtMPCapableSYNACKRX",
> +		 "NR==1 {next} {print $2}", "1");

It might be safer to increase cmd size to 256 (or even 1024) because if
I'm not mistaken, you might need here 129 chars if NS_TEST can go up to
31 chars:

> ip netns exec 1234567890123456789012345678901 nstat -asz MPTcpExtMPCapableSYNACKRX | awk 'NR==1 {next} {print $2}' | grep -q '1'

That's 128 chars but without '\0'.

But I don't think you need a v3 now: it is an issue just with the tests
and also because I know most subsystems ask not to send more than one
version per 24h ;)

BTW, excellent cover-letter, thanks for that!

> +	if (!ASSERT_OK(system(cmd), "No MPTcpExtMPCapableSYNACKRX found!"))
> +		err++;
> +
> +	return err;
> +}

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
