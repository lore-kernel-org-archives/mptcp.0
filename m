Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9209D3212
	for <mptcp@lists.linux.dev>; Mon,  2 May 2022 20:43:54 +0000 (UTC)
Received: by mail-ej1-f41.google.com with SMTP id kq17so29904575ejb.4
        for <mptcp@lists.linux.dev>; Mon, 02 May 2022 13:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=cfAL6o4Pshh+Nh7bBN0KVqk6fZxMMHCyBIcobnZP32s=;
        b=z790qh46uibDA5/N3rj4Uea+5PdJooEHhk3VihIJLoeM9byQcc/oQJW2zXL0TRDnn0
         2SCah8xBEAvYIBhICH3ndAJg8deuh+ZQ7bFWrErAjCYROBQgIoPaB0iOFMKfEpfF+fm8
         qzJvrMRzAoDT+fXjtSye0i/hRLidNLBHwfS8zzn7vXWZ532BfiB/CajaZgPiWFH7EBzV
         Oej1IxFQ7gwB+XtW3UoFIJ1g7l4R45bFhnpj3T8TQvb+EpaOkNc/3lo6WuDZ+TqFUOWV
         4a1u1hZZWbs9CVAFEsvnY2wofnc6JRezx3JZJ4Vh94Zbjjv8+pXZ6md5AK/Zxl0pHO8I
         yjgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cfAL6o4Pshh+Nh7bBN0KVqk6fZxMMHCyBIcobnZP32s=;
        b=vmt2X7J4M/dN2ko2wxpjb+j+KWTlPWBdwtjab8/V/u5H7pNxGoKKZpMcR3iqH2xEh5
         eEKmXWsKsZE5k3dnKVA75g5LEZmUv1uBD9fr2P0gawxzxmdvRQ8OYEemiu8Hi2+yIIKg
         xb4jgKKAVAsdZqn6evVIQOZA1R6qIFkFgcRrikyvdm9XRaA9tSavxpt4FDBt24NXPI8p
         DFYRdcraY019tGat48PbbSe6onRInt6T7Xb3c/ho38byaZQsEEZTq8WpjZq7XMSkZd/J
         qenx1tbp73jpjpnTwa4SwRDyIl+5CmhLGXmqlsStngE/DDOMavzqehA/nIS5qVaZwPE1
         kYYw==
X-Gm-Message-State: AOAM533tP9vYgQwcFJWf9oS51SDHoN6aGC+bhwEXqwYrf4oBli3BG/d8
	NzACrDVaQW9IfXarewKD6EpYbANqHp18OWVX
X-Google-Smtp-Source: ABdhPJyHSpX8nlGnir8PMNTU+tqZtxJ+uzSaaHj7AEv5Mun2AgGoPtWReVQzRXoYfDzdvsN/jo8pXA==
X-Received: by 2002:a17:906:c106:b0:6f4:45d9:2d85 with SMTP id do6-20020a170906c10600b006f445d92d85mr6758484ejc.493.1651524232497;
        Mon, 02 May 2022 13:43:52 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:8b1c:91db:8679:8c21? ([2a02:578:8593:1200:8b1c:91db:8679:8c21])
        by smtp.gmail.com with ESMTPSA id qp24-20020a170907a21800b006f3ef214df9sm3932665ejc.95.2022.05.02.13.43.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 May 2022 13:43:52 -0700 (PDT)
Message-ID: <647deac5-ea7c-bfcf-e1cd-5ab91a3eee29@tessares.net>
Date: Mon, 2 May 2022 22:43:51 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH mptcp-next] Squash to "selftests: bpf: verify ca_name of
 struct mptcp_sock"
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <47419fbef3ed25bd1bb9d641e4817b85ea55ecda.1651329059.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <47419fbef3ed25bd1bb9d641e4817b85ea55ecda.1651329059.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 30/04/2022 16:31, Geliang Tang wrote:
> Read /proc/sys/net/ipv4/tcp_congestion_control directly, instead of
> using sysctl.

Thank you for the patch!

Now in our tree:

- 7578ba9005cf: "squashed" in "selftests: bpf: verify ca_name of struct
mptcp_sock"
- Results: 8ae619c5e009..929d7e14ecf1 (export)


Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20220502T203959
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
