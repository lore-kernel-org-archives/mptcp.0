Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DFB472
	for <mptcp@lists.linux.dev>; Mon, 20 Sep 2021 15:43:35 +0000 (UTC)
Received: by mail-ed1-f50.google.com with SMTP id v24so63112416eda.3
        for <mptcp@lists.linux.dev>; Mon, 20 Sep 2021 08:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=to:references:cc:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+9llpubVfI9aFzOR+IP1a96N0EB1i6k5mBodnQg4Yys=;
        b=sPXn7+XQXFxcB4Wkvv8ViX8Xa5jljQJrUQUL8QrC+iQGP5M0lXyvJZaVBXTCAhszrY
         PvlxaRBjDPLmsvWgyUl1z/tmr6JkPgPJ4KJdRw1NFdcWPhpRrT4U0IKI9j+XI+t4asm5
         5OwttxqlNoR2N/AIcOkpgCOFG2pG/JARoS+I7mnSAx7LGGJwuOumK05QRVYH6ODhUPrt
         Mt26Ps/WK53pvwquwfUoiziysg437CEIWTEEovPDd+AtjvIc1sRNywUfi60XNlc4Bsnf
         BUPP0zkaH0kv7SSd7znzISxxeqMPa9IPXoajOPMr6tLCPkzVS/GoqydFpWjNda2b+oqK
         ZLWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:references:cc:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+9llpubVfI9aFzOR+IP1a96N0EB1i6k5mBodnQg4Yys=;
        b=vHLhbdwmZl/Ppfi1OeTAh+6mWHRjKakKnRgOqQAzbtilfTNftTvO3G0f5Am9dopJ02
         lov87SYQ03KUJBQOZyz8EeHSgJFnvYYm9Q54QsOEkRVb4W8Q7YGQRKlfeVQhIV7Xikqn
         nGB+paDG9Kcjc6dpe5q+UWIZB+wpK8WS38Gru/MplOh1L2tKt938V4krm/TNTL3jHSh7
         wJdQYT1hE2odwsjc2cF6eoaoMRG78JiHuzbPIx8CBtRm6+CZ5J8XskUkXm3uesEncAoR
         VANCJOw9CfRqxkVLnOyH33ExrbA0aC7SnH+W1AdRQA3eBRX5ijAkPLXSf/ugC57hPYhz
         rI9w==
X-Gm-Message-State: AOAM531otIjwU/iZifQw3CVHUMvHPJWjoNfVcWhyzBCTDei55Jwt25n1
	soMR7g+ctqD6k+A4jJ0UoIsHZUunhwLrdMvB
X-Google-Smtp-Source: ABdhPJyZOdHfbhS9BECGDrrz7dL7LDPfUEv1f5z+aT9gsgFhKW8QqjDDObEkLLY/Kb+Ok/n46oicXg==
X-Received: by 2002:a17:906:919:: with SMTP id i25mr28358574ejd.171.1632152566720;
        Mon, 20 Sep 2021 08:42:46 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id ba29sm7294782edb.5.2021.09.20.08.42.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Sep 2021 08:42:46 -0700 (PDT)
To: Paolo Abeni <pabeni@redhat.com>,
 Mat Martineau <mathew.j.martineau@linux.intel.com>
References: <0bcf04149918792f287bf56fb5a38e4a19be4fe0.1631808364.git.pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Re: [PATCH mptcp-net] mptcp: always provide MPTCP skb ext for tx skb
Message-ID: <7a42709a-8637-d9a1-ee01-765dae184385@tessares.net>
Date: Mon, 20 Sep 2021 17:42:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <0bcf04149918792f287bf56fb5a38e4a19be4fe0.1631808364.git.pabeni@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit

Hi Paolo, Mat,

On 16/09/2021 18:06, Paolo Abeni wrote:
> The mptcp code will uses whatever skb is present into
> ssk->sk_tx_skb_cache. If the skb tx cache is enabled, the
> recycle operation will clean the MPTCP extension from the
> cached skb, and the MPTCP would hit a later WARN.
> 
> Fix the issue always invoking the mptcp skb allocation
> helper, which will safely check the cached skb for the extension
> presence.

Thank you for the patch and the review!

This patch is now in our tree (fixes for net) with the Reported-by tag
and Mat's RvB tag.

Please note that as expected, I had a conflict with "mptcp: stop relying
on tcp_tx_skb_cache". As a result, 'export' is seen as unmodified
because the modification here is no longer needed thanks to "mptcp: stop
relying on tcp_tx_skb_cache".

- cc90251fe40f: mptcp: always provide MPTCP skb ext for tx skb
- 1027c0b1c29c: conflict in t/mptcp-stop-relying-on-tcp_tx_skb_cache
- Results: 1c6ca6c7576e..82229863a0d7 (diff is empty as expected)

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20210920T154149
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export/20210920T154149

(but the tests are validating the same code as before as "export" still
has the same code at the end)

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
