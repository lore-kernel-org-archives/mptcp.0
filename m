Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49332FB0
	for <mptcp@lists.linux.dev>; Thu, 22 Jul 2021 13:33:59 +0000 (UTC)
Received: by mail-ej1-f50.google.com with SMTP id hr1so8448271ejc.1
        for <mptcp@lists.linux.dev>; Thu, 22 Jul 2021 06:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=to:references:from:subject:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=Za8WJFxnosbCPcf+QupyRfbO51TJGu8WdkJljqo27pM=;
        b=B2QGdOiGuV0zvVXrdrm/tAuyi3k6OKU/YWg6LRCRWLFXy7byC2qsHLo2LYiGG8FjQ6
         91yRTpE9C6yUEF6j2dSxfr4FTDwVmlp26owmLfAztqA+60+hDN/G1ggN3FyTsM31r5rv
         yfEIvRXYBUz5nf3YQ4WKMDq0Uq4tEZAsXy/A6iA6RvI2avA6FIRgTrZDki8Woj0AfQ/5
         BLIY3d1iUv8hkLtIZsmX7csuZorAcdfwMzmvkxxigediJT27dm5ThBzKWIOI1GRgLLvs
         nB63Z1x+BJ9E0/CHOXsBDuLb8MiEQKozClsbvP8OHi+8lS2gfT1Efy3iLXbL8qzsuMXo
         uzGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Za8WJFxnosbCPcf+QupyRfbO51TJGu8WdkJljqo27pM=;
        b=P56nSHjy4hz7QGF7XryG7bi92+NIU954P3rpXn7T1vYjidsQuA3Daa+DoZhCDXpHyM
         opIxud4Ic//8wHfKZI5KxlfpQ0kPX+LSyViZ8H8i/d1BoZasb9y+AbNClAY2SUwiYpM4
         y+ioEokpne8oIVWBrpL6qhCxGFeetHjFY0JFpYL7L5yXgoYTelDS2TPfI9ZyEvebocCE
         R0V/tluSwDCi2YKoxA42RWgbossUwNTUxDCLEacZ5eUmh7jQ3r3gmITztly3kELw+JGi
         tKYB+AkJhjtnZz2IOGHJkTXPUKv0VN04Hw5qafDVN5VkuOm0gkCGVv34b1kDdRvOCQrv
         y8hg==
X-Gm-Message-State: AOAM531BiNE3XzcWHHRcK7oZC/k+PgFA1LO6T8PsXp0fwEpBXsmZBl/+
	zwzIRQottFrRLLJ0IL67Zh+oL144WKpsNaN+uoM=
X-Google-Smtp-Source: ABdhPJz876iv0TVpYIozA/wEiesKd8NaRWuRz5tjHrLdayTu7ZSQvObtRU4ZCKm83cUYD1Yoita5aA==
X-Received: by 2002:a17:906:7a4d:: with SMTP id i13mr42813576ejo.496.1626960838063;
        Thu, 22 Jul 2021 06:33:58 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:8391:ca7f:9c1b:4236])
        by smtp.gmail.com with ESMTPSA id z25sm9458576ejb.9.2021.07.22.06.33.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jul 2021 06:33:57 -0700 (PDT)
To: Geliang Tang <geliangtang@gmail.com>, mptcp@lists.linux.dev
References: <cover.1626877655.git.geliangtang@gmail.com>
 <b5f63eb4ad680a99fc806d2406968a6a5f272f01.1626877655.git.geliangtang@gmail.com>
 <0000f0168f0d8d1cd34bbe5463aed721225446e2.1626877655.git.geliangtang@gmail.com>
 <93ffe9fbfda6d2efdbab73373b6efbbce3a36b00.1626877655.git.geliangtang@gmail.com>
 <f1175761821947749ac9724deb3009b9b2747bbd.1626877655.git.geliangtang@gmail.com>
 <e9de213a59a066c6beaba2895a7c60412b654601.1626877655.git.geliangtang@gmail.com>
 <149236d46fe59a177a2f36a5c6e45941a1e0c2fd.1626877655.git.geliangtang@gmail.com>
 <d40b7b32bc427e5d43fce298b60e1040398977ac.1626877655.git.geliangtang@gmail.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Re: [MPTCP][PATCH v2 mptcp-next 07/10] mptcp: add proc file
 local_addr_list
Message-ID: <9bf5449b-d812-e68b-56c2-d363bb84a02b@tessares.net>
Date: Thu, 22 Jul 2021 15:33:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <d40b7b32bc427e5d43fce298b60e1040398977ac.1626877655.git.geliangtang@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 21/07/2021 16:31, Geliang Tang wrote:
> This patch added a proc file /proc/net/local_addr_list to show all
> the addresses on the local address list.

This looks like a very useful info and handy to read but I don't think
upstream -net maintainers will accept new entries in /proc/net.
Instead, a Netlink API should be used if I'm not mistaken.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
