Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89F57A
	for <mptcp@lists.linux.dev>; Sat, 11 Jun 2022 07:10:53 +0000 (UTC)
Received: by mail-ej1-f54.google.com with SMTP id g25so1815937ejh.9
        for <mptcp@lists.linux.dev>; Sat, 11 Jun 2022 00:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:cc:in-reply-to:content-transfer-encoding;
        bh=hsjqafvdOgp79iG+jppM6kK4eSFnVq7U77caQfgxetM=;
        b=MTvUyFayQWtWcaW90Ac4d0XPuHkHR7pFWbroO/S2ZCKtUl/zA0WmMF/Cd0xkl8uQyD
         n41tG+X899e57ks3Lu8c+K3yWRbukyXy236Wy5KWV+r1sUKpvnw6gm1VDyDtSa3uc63A
         F12uCRGwShgI+x2kNqWY3W/IyP18qyM3KOJZ1EK+USor3UCKqXuuJhJ+DmcFgPUcFE9F
         B5dVRi3GyJKphnQ65uPCNyAXiFBq5Myk6kr/JpUueJ5mPXHlDtSj7EmRllNic+ejdQ4i
         /1dqHG0fOKYet+OUVWEW5nF7f0OVJVTHXlKO1kVTwRkRr+/a1cis9ZXCDwaPqsStjExi
         ctpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:cc:in-reply-to
         :content-transfer-encoding;
        bh=hsjqafvdOgp79iG+jppM6kK4eSFnVq7U77caQfgxetM=;
        b=o4AUV1uhZnlL62fE5ie4AUyCHSM/KPDJePO0iHmI3Nru5f2W5UcCEVvS0emGp7l4jp
         sxtd4+nrHhww6Lx+4j9dCbsm3LhI3TxvTJx3LZAz8SKI4Gh+5Y9CB+Sn39II3PAsMGZ3
         62U9gkt8mCrLYs5EcBdJAMtd8HEk9sm3Zm5V3RpOf0yqORCFUy440ubvXVU3AGxgB6Y6
         +m8OZrZaN+5UJEjPqVWFBfnLYgKdNCUwUAKmtdahJWB42zTVyNHRk3OJnWAJSUlqIWv0
         /xYsI0Ghs2b5HGUAqaCAt3rcTf1df3l+SAzd1QmE/4IzzR2mBhVE+6rneAK+rjN4/pD2
         CAZQ==
X-Gm-Message-State: AOAM531kYishgBVirVkz1YSwBAFkKoeR7l8cEr/gU2n24CTV+xKcouma
	qjz8jpH6/Ot627CPbaJK8ZypCvkQDb4wCn4T
X-Google-Smtp-Source: ABdhPJyakCQrtHIF5OiholSm7qXbMucUBmm+5oSooNjDUDGz0muW42e07dwIbDka80j6zVIbftNZQA==
X-Received: by 2002:a17:907:1ca8:b0:70c:68ce:dade with SMTP id nb40-20020a1709071ca800b0070c68cedademr41034785ejc.723.1654931451284;
        Sat, 11 Jun 2022 00:10:51 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:aeee:a0c0:6fd1:9631? ([2a02:578:8593:1200:aeee:a0c0:6fd1:9631])
        by smtp.gmail.com with ESMTPSA id m6-20020a50d7c6000000b0042dd60352d1sm893175edj.35.2022.06.11.00.10.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Jun 2022 00:10:50 -0700 (PDT)
Message-ID: <5496b5da-9f37-f4ab-0493-86b3556431a8@tessares.net>
Date: Sat, 11 Jun 2022 09:10:50 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH mptcp-next] selftests: mptcp: avoid Terminated messages in
 userspace_pm
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>
References: <829ce50fa6d830c6c5ed371e7741b6d30792d905.1654829977.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
In-Reply-To: <829ce50fa6d830c6c5ed371e7741b6d30792d905.1654829977.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 10/06/2022 05:00, Geliang Tang wrote:
> There're some 'Terminated' messages in the output of userspace pm tests
> script after killing './pm_nl_ctl events' processes:
> 
> Created network namespaces ns1, ns2         			[OK]
> ./userspace_pm.sh: line 166: 13735 Terminated              ip netns exec "$ns2" ./pm_nl_ctl events >> "$client_evts" 2>&1
> ./userspace_pm.sh: line 172: 13737 Terminated              ip netns exec "$ns1" ./pm_nl_ctl events >> "$server_evts" 2>&1
> Established IPv4 MPTCP Connection ns2 => ns1    		[OK]
> ./userspace_pm.sh: line 166: 13753 Terminated              ip netns exec "$ns2" ./pm_nl_ctl events >> "$client_evts" 2>&1
> ./userspace_pm.sh: line 172: 13755 Terminated              ip netns exec "$ns1" ./pm_nl_ctl events >> "$server_evts" 2>&1
> Established IPv6 MPTCP Connection ns2 => ns1    		[OK]
> ADD_ADDR 10.0.2.2 (ns2) => ns1, invalid token    		[OK]
> 
> This patch adds 'wait $pid 2>/dev/null' commands after 'kill $pid'
> to avoid printing out these Terminated messages.
> 
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
>  .../testing/selftests/net/mptcp/userspace_pm.sh | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
> index 78d0bb640b11..eaa54c3f75fb 100755
> --- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
> +++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
> @@ -49,15 +49,18 @@ cleanup()
>  	fi
>  	if [ $server4_pid -ne 0 ]; then
>  		kill $server4_pid > /dev/null 2>&1
> +		wait $server4_pid 2>/dev/null

Good idea to wait!

Do you think it would be interesting to add a new helper doing something
like this?

  # $1: PID
  kill_wait() {
      kill "${1}" &>/dev/null
      wait "${1}" 2>/dev/null
  }

or even:

  # $1: PID
  kill_wait() {
      local pid="${1}"

      if [ "${pid}" -ne 0 ]; then
          kill "${pid}" &>/dev/null
          wait "${pid}" 2>/dev/null
      fi
  }

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
