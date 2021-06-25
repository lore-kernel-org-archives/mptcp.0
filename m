Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33A9177
	for <mptcp@lists.linux.dev>; Fri, 25 Jun 2021 08:47:07 +0000 (UTC)
Received: by mail-ed1-f44.google.com with SMTP id s15so12319682edt.13
        for <mptcp@lists.linux.dev>; Fri, 25 Jun 2021 01:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hCptlYPBTH33X1I9m8GgzF7T6+5gT5+W0bKYh+YkMis=;
        b=faXqpESeSd+8PJthuAxeTUXEcwMw96Bfe1kZZWwPOrSC/JBx3TigwZLR6Xg7H1HnMM
         JfGQJp2irw0udVRAv3JKaR5hkOeLwycu8krB7CybinTBJpodNdjU1vLRsZ+7AdysvPSa
         PhO9g+6aPFBQsVEPr9zMsYeTGyLPVticBpW1mJvbPK/bi3eI8j5DUl+VoywAZY1jlXRw
         77webdnDl7dwlhXCPjlH/iTRgpiCm7rqSa0b5nBQvDFo+TNtViVwy8EK/bD9C81tNK5g
         ing3j1AV/ZoPixRJA6AFlMk26NrTIcVm21uHt2quKPoN/BOaeCgQvQtX3y+1qYpOjvf3
         jM7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hCptlYPBTH33X1I9m8GgzF7T6+5gT5+W0bKYh+YkMis=;
        b=VDs4cj5Hdqit5mcJiFXjBwtc0ZLot8JXg9qPjWjnDobwsKPOYHfKMTbqA5MtXAOVkU
         +KMxo/xe/Iomuz4yKcUSBeTBxoKwaPXWnWZhp82np59/wxdb9NZNxGTzvSpxlE0MAJEv
         eIcwiEfDGz2dfCVEckDpgsa+1YoA6ThL8H15x1IhgyymkZw4E63M36upFgLBiVvq/5CN
         3BoQ46ES5VOC+2SKlFii9jD9G1hHijMNX1ik1Gr61TFpCupUqXgnc/HVXpOJjI/+r33A
         pJ0W65IJOwLQ/8qgQM7UjB4+FGQ7/nlU+hiKqhYL/YkF6+yIxH7jMoIeBQ8K2YTEXYfp
         pSzw==
X-Gm-Message-State: AOAM533ZeJjCWJsURVjoPYX9hBMvNf3oJ1eh1xlq1EyHizMT7rM1lpTR
	45Bs7xfS3729Hj0QEunyIsSZSDhqmRrosG2SbNY=
X-Google-Smtp-Source: ABdhPJwaoB5gmHf31MQZNZnnN10XPDzO3owz8WOH2Yi3XiZESx1bDD4EnkxK66L5aAoOQ/RNWvcxbA==
X-Received: by 2002:aa7:c0da:: with SMTP id j26mr13094422edp.38.1624610825873;
        Fri, 25 Jun 2021 01:47:05 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:3f3:57d7:aba5:347d])
        by smtp.gmail.com with ESMTPSA id s7sm2492976ejd.88.2021.06.25.01.47.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jun 2021 01:47:05 -0700 (PDT)
Subject: Re: [bug report] mptcp: refine mptcp_cleanup_rbuf
To: Dan Carpenter <dan.carpenter@oracle.com>, pabeni@redhat.com
Cc: mptcp@lists.linux.dev
References: <YNWTLmF3Cne09pTT@mwanda>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <0ed6875f-f88a-ae2f-c568-0cc81467c4ec@tessares.net>
Date: Fri, 25 Jun 2021 10:47:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <YNWTLmF3Cne09pTT@mwanda>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

Hi Dan,

Thank you for the good bug report (as always)!

On 25/06/2021 10:26, Dan Carpenter wrote:
> The patch fde56eea01f9: "mptcp: refine mptcp_cleanup_rbuf" from Jun
> 22, 2021, leads to the following static checker warning:
> 
> 	net/mptcp/protocol.c:464 mptcp_subflow_could_cleanup()
> 	warn: masking a bool
> 
> net/mptcp/protocol.c
>    455  static bool mptcp_subflow_could_cleanup(const struct sock *ssk, bool rx_empty)
>    456  {
>    457          const struct inet_connection_sock *icsk = inet_csk(ssk);
>    458          bool ack_pending = READ_ONCE(icsk->icsk_ack.pending);
>                 ^^^^^^^^^^^^^^^^

It should be a u8 I presume, no reason to use a boolean here:

---------- 8< ----------

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c

index ddce5b7bbefd..199a36fe4f69 100644

--- a/net/mptcp/protocol.c

+++ b/net/mptcp/protocol.c

@@ -455,7 +455,7 @@ static void mptcp_subflow_cleanup_rbuf(struct sock *ssk)

 static bool mptcp_subflow_could_cleanup(const struct sock *ssk, bool
rx_empty)

 {

        const struct inet_connection_sock *icsk = inet_csk(ssk);

-       bool ack_pending = READ_ONCE(icsk->icsk_ack.pending);

+       u8 ack_pending = READ_ONCE(icsk->icsk_ack.pending);

        const struct tcp_sock *tp = tcp_sk(ssk);



        return (ack_pending & ICSK_ACK_SCHED) &&


---------- 8< ----------

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
