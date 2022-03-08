Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DE94369
	for <mptcp@lists.linux.dev>; Tue,  8 Mar 2022 08:46:30 +0000 (UTC)
Received: by mail-ej1-f47.google.com with SMTP id qa43so37477571ejc.12
        for <mptcp@lists.linux.dev>; Tue, 08 Mar 2022 00:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=sV5C7aAEbE5mrZTkWja0ea+6IDQHX3hV/tqFa6YeaiY=;
        b=Gid+FxS2QAdOGwIPkPKEvWKnPLHQd/yMg5QUpcoQYcEraeHyhomYVq6nlwG0GjzQKV
         jHK/h5n+tN5l7Zgvfeg+A8t5Jb7wLBvTqmC558ZC+jjuYJJ5ASIOj62O1MdlH/Shinkd
         aDDM6SJ9M3kc9cdR2I1Bl85zub56kq+w8TTZ6WgRs1+w34uA7DFry93cCDsaFHpIg9Ce
         6j+sYCCGU01Ed9wqT/S2sVJC/CdGr4Orwb+86xSd8+rE3h/PV87SItFbCQm0L2u1newx
         E8E1NN7bLXWWcSy6rGlDIBPSpm3Qhjtri42JSyTWjUdNSl09EqKJNP++UOqnBnkTGCpa
         aHtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=sV5C7aAEbE5mrZTkWja0ea+6IDQHX3hV/tqFa6YeaiY=;
        b=OdC5j7RGUsg0iVViL7w+3U7UWjHN2HdwA771UVOnctRknQOxjcS8DeVupcp4V/uS7f
         qQKEZlLsyl1PFREob9gjmoyCJ7iinmdmQW/EFePJ19a8Jh8/zWwivi6vKBZR7VvzzmHb
         3cKzq8puEI/AQAZ78HMnMTGoBq77tIVMydickmcqzUrbN2LaJZ7aCnwV5C833rYjhRVw
         PfE9+zxiTnlRKL7/P32FqEJYy0jqIdUO2LcSnORZULIfzX7o53+zTuAtXW5LpnRMTkJj
         U9YHZYBk7Iw7/tTB6gzK6i1OP+S0NtF/tPws4W8wXA4+3siup3tdbJQjj/SIeUs97pH8
         6QQQ==
X-Gm-Message-State: AOAM532mGuSJF6YNhsgPwsBNh5r6lmeCOoj/L6OZnDU35Y6dyo9WYSwp
	kbsZK3onBVUnY0co5iO18eRDWVKEHoWgww==
X-Google-Smtp-Source: ABdhPJybSNrvlnoK7hJ7v/ElmsM5PRQI9WBiXFtHKYnUsJpSMPQFx5lKZRkq4aEiExQUIjE33M3CLQ==
X-Received: by 2002:a17:907:1b20:b0:6da:649b:d99e with SMTP id mp32-20020a1709071b2000b006da649bd99emr12141911ejc.712.1646729188895;
        Tue, 08 Mar 2022 00:46:28 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:4a74:9d9d:42fe:ff08? ([2a02:578:8593:1200:4a74:9d9d:42fe:ff08])
        by smtp.gmail.com with ESMTPSA id go18-20020a1709070d9200b006d650ff4b26sm5533101ejc.209.2022.03.08.00.46.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 00:46:28 -0800 (PST)
Message-ID: <8fdc4ace-2cda-21f9-fcc0-fcd02848e790@tessares.net>
Date: Tue, 8 Mar 2022 09:46:27 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH mptcp-next v7 4/4] selftests: bpf: add skc_to_mptcp_sock
 test
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1646711943.git.geliang.tang@suse.com>
 <522733c62616c526a072ab5f8bc211efad1bbd66.1646711943.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <522733c62616c526a072ab5f8bc211efad1bbd66.1646711943.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

Thank you for the new version!

I think we are almost there, just some small stuff in this patch 4/4.

On 08/03/2022 05:02, Geliang Tang wrote:
> This patch extended the MPTCP test base, to exercise the new helper
> bpf_skc_to_mptcp_sock() from C test as Alexei suggested in v3.

May you eventually add a link to this review? It might help to
remembering what was said in 2020 :)

> Added a new function verify_msk() to verify the msk token, and a new
> function get_msk_token() to parse the msk token from the output of the
> command 'ip mptcp monitor'.

I hope it is OK for BPF maintainers to use 'ip mptcp monitor' but I see
they already use 'ip' commands from .c code in other BPF tests.

> diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> index 04aef0f147dc..d60525d5124f 100644
> --- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
> +++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> @@ -3,9 +3,12 @@
>  #include "cgroup_helpers.h"
>  #include "network_helpers.h"
>  
> +char monitor_log_path[64];
> +
>  struct mptcp_storage {
>  	__u32 invoked;
>  	__u32 is_mptcp;
> +	__u32 token;
>  };
>  
>  static int verify_sk(int map_fd, int client_fd, const char *msg, __u32 is_mptcp)
> @@ -42,6 +45,62 @@ static int verify_sk(int map_fd, int client_fd, const char *msg, __u32 is_mptcp)
>  	return err;
>  }
>  
> +static __u32 get_msk_token(void)
> +{
> +	char *prefix = "[       CREATED] token=";
> +	char buf[32] = {};
> +	__u32 token = 0;
> +	ssize_t len;
> +	int fd;
> +
> +	fd = open(monitor_log_path, O_RDONLY);
> +	if (CHECK_FAIL(fd < 0)) {
> +		log_err("Failed to open %s", monitor_log_path);
> +		goto err;
> +	}
> +
> +	len = read(fd, buf, sizeof(buf));
> +	if (CHECK_FAIL(len < 0)) {
> +		log_err("Failed to read %s", monitor_log_path);
> +		goto err;
> +	}
> +
> +	if (strncmp(buf, prefix, strlen(prefix))) {
> +		log_err("Invalid prefix %s", buf);
> +		goto err;
> +	}
> +
> +	token = strtol(buf + strlen(prefix), NULL, 16);

I don't know if it is safe to do that: if I'm not mistaken, 'buf' will
not end with a '\0'. If you expect a token written in 8 char and a
"prefix" of 24 chars -- total = 32 char + '\0' --, probably best to have
a buffer of 33 bytes, read 32 and make sure the 33th is set to 0
(already the case with your initialisation), no?

> +
> +err:
> +	close(fd);
> +	return token;
> +}
> +
> +static int verify_msk(int map_fd, int client_fd, __u32 token)
> +{
> +	int err = 0, cfd = client_fd;
> +	struct mptcp_storage val;
> +
> +	if (token <= 0) {
> +		log_err("Unexpected token %x", token);
> +		return -1;
> +	}
> +
> +	if (CHECK_FAIL(bpf_map_lookup_elem(map_fd, &cfd, &val) < 0)) {
> +		perror("Failed to read socket storage");
> +		return -1;
> +	}

I think you should also check the value of val.invoked and val.mptcp
like above, probably in a common function (verify_sk()? see below). That
would help in case of issues with this test.

> +
> +	if (val.token != token) {
> +		log_err("Unexpected mptcp_sock.token %x != %x",
> +			val.token, token);
> +		err++;
> +	}
> +
> +	return err;
> +}
> +
>  static int run_test(int cgroup_fd, int server_fd, bool is_mptcp)
>  {
>  	int client_fd, prog_fd, map_fd, err;
> @@ -79,6 +138,9 @@ static int run_test(int cgroup_fd, int server_fd, bool is_mptcp)
>  	err += is_mptcp ? verify_sk(map_fd, client_fd, "MPTCP subflow socket", 1) :
>  			  verify_sk(map_fd, client_fd, "plain TCP socket", 0);

There is still a comment about MPTCP socket in verify_sk which no longer
makes sense I think.

What do you think about renaming verify_sk to verify_tsk() which would
be dedicated to TCP (only taking map_fd and client_fd args) and
verify_msk() for MPTCP?

In other words, for MPTCP sockets, you would only call verify_msk().

  err += is_mptcp ? verify_msk(map_fd, client_fd) :
                    verify_tsk(map_fd, client_fd);

In this case you can remove the comment about MPTCP in verify_sk().

>  
> +	if (is_mptcp)
> +		err += verify_msk(map_fd, client_fd, get_msk_token());
> +
>  close_client_fd:
>  	close(client_fd);

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
