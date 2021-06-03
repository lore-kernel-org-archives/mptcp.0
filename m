Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454DD70
	for <mptcp@lists.linux.dev>; Thu,  3 Jun 2021 14:59:04 +0000 (UTC)
Received: by mail-ed1-f52.google.com with SMTP id r11so7447786edt.13
        for <mptcp@lists.linux.dev>; Thu, 03 Jun 2021 07:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=H2n8iAykoiaVz4T/SAtSY5afyWK9KlAIlpRA63HZfTY=;
        b=EkifTixhC5k0dABxtfOoB6n+XBdUStoblVAv6PFH99Ok7p0zU2HSeDtNgKH/fO2X7w
         +F6cMOYmvnanq72Yqq14TqgzenEerN+2bF96175LS4keNdaNnUnQdyFL7P4pNyqh6PkI
         w3ml7njMsffZu3wmnfa6pAVT8KHtefrtPE6DH8D9JkPiUUsWwrZyNGs2jo970nW2aq0e
         XhnH3RHqMi0FJ0IVHb2V4aUOaGbsVEGFdodwjz4kg2gLxARpPatAY+bS4TptHHwf4lK1
         A2SUneq6LUSDgriLihSJ/KpSOaui+QbEn8SGzIw7/iP/eznNvfFvVHVSu7Hvr6ZRANWt
         ddeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=H2n8iAykoiaVz4T/SAtSY5afyWK9KlAIlpRA63HZfTY=;
        b=Cij8W6/4LS01DApsfKoZOcjDZlRfGlc+q1RkW63m0FHtbgv8j0BeqOf0Fu17BGTJN+
         EoClDRnAIY5AWEc0telrEJ8SJPLd2SsLESXzMuxyv9Mmq+0UbPhg5u97+lzAQMXyXAgI
         eP6vnS6/DVqIu04Vb0XNnDSzYF7Wb31cqOMKlO1HtGKMzTVN8z2okM8UdPRY+NzigajA
         7J0QJrdPsktDQRg5aGfsSB61eQRfujEAm1FkGPhIJvudR74x26PbwR7bSW8meuADzraB
         doUhdVIC6/1CKfvnAVDV41ElXDi5sDsu03Ml1JgUXciZC+Y53TS8Sc1xWJ+y45ytk88U
         tuZQ==
X-Gm-Message-State: AOAM530Bx6pJoMf7GKm+VADEn6pX2E3XrwNQyxdJCVLPFNrIX+FgrCyF
	q9xxO0JmWcC8z3/oyQthPt2XKYiZD1OFb3cfJWo=
X-Google-Smtp-Source: ABdhPJxCOQGY0BQ5oC4PCk2pAt7lqvySNnybpNO4DFBqnYolkdSSegSP5+5yIdsxyKym4lbyNk6EHQ==
X-Received: by 2002:a05:6402:645:: with SMTP id u5mr170793edx.293.1622732343401;
        Thu, 03 Jun 2021 07:59:03 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:94d5:e4e:f978:9a29])
        by smtp.gmail.com with ESMTPSA id q9sm1806395edw.51.2021.06.03.07.59.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jun 2021 07:59:03 -0700 (PDT)
Subject: Re: [MPTCP][PATCH mptcp-next] Squash to "mptcp: generate the data
 checksum"
To: Geliang Tang <geliangtang@gmail.com>, mptcp@lists.linux.dev
References: <ae2099811b8395f7718855c5c7d412b26d960c95.1621321549.git.geliangtang@gmail.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <1f7c5cea-28ba-7a90-2499-f9e0cb5d1193@tessares.net>
Date: Thu, 3 Jun 2021 16:59:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <ae2099811b8395f7718855c5c7d412b26d960c95.1621321549.git.geliangtang@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

Hi Geliang, Mat,

On 18/05/2021 09:06, Geliang Tang wrote:
> Move this line "__wsum csum = ~csum_unfold(mpext->csum);" from "mptcp:
> validate the data checksum" to "mptcp: generate the data checksum".

Sorry for the delay!

This is now applied in our tree:

- 982a61af0143: "squashed" in "mptcp: generate the data checksum"
- Results: e61f1205c3fe..df4fcde34fab

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20210603T145651
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export/20210603T145651

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
