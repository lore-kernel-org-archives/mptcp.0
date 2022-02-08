Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6EA2F24
	for <mptcp@lists.linux.dev>; Tue,  8 Feb 2022 21:25:51 +0000 (UTC)
Received: by mail-ed1-f46.google.com with SMTP id ch26so999259edb.12
        for <mptcp@lists.linux.dev>; Tue, 08 Feb 2022 13:25:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:cc:in-reply-to:content-transfer-encoding;
        bh=XeI4S25H6a5xsUNCjjv1xDgM4A8G2d+vHBQkxu3P0pk=;
        b=a19wv8XDqozRNfuKI7xT+3Nha2W2F6+PdkwOsbnZ9bB+Frde3S0ezuxxS+cOxS6MqO
         xbwIPQJUKK6N42wwd3zmZZAcIFYUqWRy5veJXJGeABl6RFsFj99EhOJBAOCTY2OYVycF
         i5nAhlkhb9H7tA5GizR/nmVvrWeWRVpVSniOmbslC6vGK+WBWZe+W0KKf1415uWpgAhu
         N5GT4kV2bDT9RWI7PN3K+0HGBhAqi0mGsOaHZB4XjvpPkXm2zIl5CCPMJU9K+8LwB92O
         c0IZw9EgHrVG2/qAef97vfRkG7UxIwZX2Ncf7sbQNIXUgiYGWMFXtpx43aeSeXwi+gNK
         uhPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:cc:in-reply-to
         :content-transfer-encoding;
        bh=XeI4S25H6a5xsUNCjjv1xDgM4A8G2d+vHBQkxu3P0pk=;
        b=7ZpmrXMmchLITs8HaYPiPw3DweZRjgPgfVYQWOeOIIbqU3uTylsC1NjDZ7EX9Ti0mk
         i98cTKHvmsW1nPWwq5FM7p5dAVJYJYaav6pghloywi2lKtWkm67XW9hM9a8QDBakYvvL
         JlSyQZgVUzcst9DXhVFZDEtxmGa0jjTxOohodX4UuEIUoUoVteYnkD7x1xdyn8Aj/9t8
         0dItAezEskuJQH2L8vJEmhQAzXrZ0jk+Em7ndrbRZU+CpI8wqFTcKjl+GrW7fQ1wek2u
         x9M2PKDDfVQ5NOtBcq92RVhIUsdMNLsNfsYJLAcQT0qIwEjR9DLg7vcabUT2tvuX0Awb
         klfA==
X-Gm-Message-State: AOAM532n1y04oaRnBmKR8rn3xXMS6HjVNv4uSK2XqLu4rTE7w388Lq5V
	Qq4DtEktcX7k+RYCSpATq4sEcQ==
X-Google-Smtp-Source: ABdhPJygQ2U6rTd+s5AH+H2pSzcVMIRO700W90pwSouPUAxnwgmmxxfCm+Jj2nw0tmPas2xD2fhgnA==
X-Received: by 2002:a50:fc06:: with SMTP id i6mr6475490edr.89.1644355549474;
        Tue, 08 Feb 2022 13:25:49 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:de24:e471:fe12:b481? ([2a02:578:8593:1200:de24:e471:fe12:b481])
        by smtp.gmail.com with ESMTPSA id vp8sm4493104ejb.85.2022.02.08.13.25.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Feb 2022 13:25:49 -0800 (PST)
Message-ID: <0fcbb69f-1e23-be3c-aea0-86bafb3a68fb@tessares.net>
Date: Tue, 8 Feb 2022 22:25:47 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH mptcp-net v2 2/4] mptcp: fix race in incoming ADD_ADDR
 option processing.
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>
References: <cover.1644346664.git.pabeni@redhat.com>
 <9055dfabebe975c34e5f741885e1c70ecb49da36.1644346664.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
In-Reply-To: <9055dfabebe975c34e5f741885e1c70ecb49da36.1644346664.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Paolo,

On 08/02/2022 20:06, Paolo Abeni wrote:
> If an MPTCP endpoint received moltiple consecutive incoming
> ADD_ADDR options, mptcp_pm_add_addr_received() can overwrite
> the current remote address value after the PM lock is released
> in mptcp_pm_nl_add_addr_received() and before such address
> is echoed.
> 
> Fix the issue caching the remote address value a little earlier
> and always using the cached value after releasing the PM lock.

Thank you for looking at that!

It seems really helping for me: 500 iterations without issues! I guess
we can add:

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/254

(I guess we don't need Reported/Tested-by tags.)

Not related to that but do you think we could have a similar issue with
RM_ADDR (issues/225)?


But one important thing: this series introduces a regression apparently:
packetdrill ADD_ADDR tests are now failing because the port is missing
in the echo packet:

---------- 8< ----------
Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Unstable: 2 failed test(s): packetdrill_add_addr selftest_mptcp_join 🔴:
  - Task: https://cirrus-ci.com/task/5025097999187968
  - Summary:
https://api.cirrus-ci.com/v1/artifact/task/5025097999187968/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 1 failed test(s): packetdrill_add_addr 🔴:
  - Task: https://cirrus-ci.com/task/4765935646015488
  - Summary:
https://api.cirrus-ci.com/v1/artifact/task/4765935646015488/summary/summary.txt

Initiator: Patchew Applier
Commits:
https://github.com/multipath-tcp/mptcp_net-next/commits/34bad3e35cbc
---------- 8< ----------

This seems to be due to this patch 2/4.

> 
> Fixes: f7efc7771eac ("mptcp: drop argument port from mptcp_pm_announce_addr")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
>  net/mptcp/pm_netlink.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index fb8d4bfcfbd6..4b6aa89d45a5 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -660,6 +660,7 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
>  	unsigned int add_addr_accept_max;
>  	struct mptcp_addr_info remote;
>  	unsigned int subflows_max;
> +	bool reset_port;

I'm very surprise the compiler doesn't complain about this line because
reset_port can be used later while not having been set before. Is it
normal with 'bool'?


Setting it to false by default fixes the issue with packetdrill on my side:

---------- 8< ----------
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 4b6aa89d45a5..98b485406afa 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -660,7 +660,7 @@ static void mptcp_pm_nl_add_addr_received(struct
mptcp_sock *msk)
        unsigned int add_addr_accept_max;
        struct mptcp_addr_info remote;
        unsigned int subflows_max;
-       bool reset_port;
+       bool reset_port = false;
        int i, nr;

        add_addr_accept_max = mptcp_pm_get_add_addr_accept_max(msk);
---------- 8< ----------

(I can fix the issue when applying the patch if it is easier)

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
