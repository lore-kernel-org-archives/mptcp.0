Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B68111B
	for <mptcp@lists.linux.dev>; Wed, 22 Jun 2022 20:43:03 +0000 (UTC)
Received: by mail-ed1-f54.google.com with SMTP id ej4so21627059edb.7
        for <mptcp@lists.linux.dev>; Wed, 22 Jun 2022 13:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:cc:from:in-reply-to:content-transfer-encoding;
        bh=YCy363C8P0ivTez5ECabRA24aB7xixz8XqDSW9Md/FU=;
        b=JjhjZ0oVnncC7+vYuIgzVdcqhJvc1Vq6miJWJ3n6U73CDZDTXbRzDSNKXrOu7y3a3n
         TSgd09AuevfPRBjBr5auoYvNXKLB7HjXOXbM2FPF/pqQUsPyj8VvZpHdrqNxaXdtB6DM
         EWMuGG5iTYPp9Dxh6COTs1Lgei/t3+1Hze4EjBpActILvmYiWTWl0bLtxCjRTP2jJvNH
         fNkfCUOc2SUS0ycpTyq830V4ZuejG7s2Qe9LFz0Esx189Igd1QIhfZ1cWghJuszowmqC
         6h1tXiUg+kIUCoF2SOFVuJlJV+p9qxfCcGbud/BE0jTDOAmVDZOqagk6Ng4rRbO/VgBo
         m5dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:cc:from:in-reply-to
         :content-transfer-encoding;
        bh=YCy363C8P0ivTez5ECabRA24aB7xixz8XqDSW9Md/FU=;
        b=u08p+yyaYSYbGH2X64ySDc+b3TSLwxkqk+GruMsF3ShN+ooeS+jNJkiYxSXUbsEgNA
         kIB51rGxBFyr0iapUtwWSaEl5R3N7MmUAzq33uZLOV1SiK+D/66FP/Q3yxnC0jkwH1K0
         QlqvCXKHYMEq/VPO2qajUpZf9O6att8o8wHOV4yGNFHv5sJE/vpb1LexXNBKUTHkCezT
         maKqpbwlTi3bMepoNA1LAGOs/yarn1rqX+uyhKoA1pJkZcf0pTp5sJHdS1eskpBCr/mL
         MKuY5RQqQJ2I3Bpe9VESs9NFUdVx7JtmI/7PX93bpkAmWnFZC/ayzr6ZQxXNdn8aB67M
         HIiw==
X-Gm-Message-State: AJIora+vc5IuT7wIJxXNbAJ02XX+tFLxl+0AXdIRFErInB+oy4Z8iGDz
	mOepXFcWWT1UDLksEnw+FEpbXvPUasqWgA==
X-Google-Smtp-Source: AGRyM1tIDV3IUocrjKtb0DtHGsfbnQDNrjcUF2sX2DKieA+vK+UjfwLdPDRvw7zEGn7N6/u5XcoMoA==
X-Received: by 2002:a50:ef04:0:b0:435:6560:abba with SMTP id m4-20020a50ef04000000b004356560abbamr6388698eds.3.1655930582216;
        Wed, 22 Jun 2022 13:43:02 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:e063:12b5:8fdc:749e? ([2a02:578:8593:1200:e063:12b5:8fdc:749e])
        by smtp.gmail.com with ESMTPSA id u9-20020a1709061da900b006fef557bb7asm9839386ejh.80.2022.06.22.13.43.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 13:43:01 -0700 (PDT)
Message-ID: <1a5047e5-7ff0-c3ee-5d54-97990e7c8755@tessares.net>
Date: Wed, 22 Jun 2022 22:43:01 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v5 mptcp-net 0/6] mptcp: mp_fail related fixes
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>
References: <cover.1655829222.git.pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <cover.1655829222.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo, Mat,

On 21/06/2022 19:23, Paolo Abeni wrote:
> While cooking a follow-up for "mptcp: invoke MP_FAIL response when
> needed" I stumbled upon a few other MP_FAIL related issues hit my
> the self-tests while mangling the above.
> 
> All the patches for for the -net tree, and should be applied in-order
> around to the squashed-to patch.

Thank you for the patches and the reviews!

Just applied in our tree (fixes for -net, around "mptcp: invoke MP_FAIL
response when needed" patch) with Mat's RvB tag and without typos
(spelling from codespell, double parenthesis and removed empty line)

New patches for t/upstream-net:
- 8ba09e2ea328: mptcp: fix error mibs accounting
- 3b5f3287d01b: mptcp: introduce MAPPING_BAD_CSUM

- cd89e66cbec2: "squashed" patch 3/6 in "mptcp: invoke MP_FAIL response
when needed"
- 3675d85be654: "Signed-off-by" + "Co-developed-by"
- 341e2db12838: tg:msg: update commit message

- efb55524f8bd: mptcp: fix shutdown vs fallback race
- f2084a8aaf07: mptcp: consistent map handling on failure
- 144485c43714: mptcp: fix race on unaccepted mptcp sockets

- Results: 17a4b2aeac43..7db03aa2d67f (export-net)


New patches for t/upstream:
- 8ba09e2ea328: mptcp: fix error mibs accounting
- 3b5f3287d01b: mptcp: introduce MAPPING_BAD_CSUM

- cd89e66cbec2: "squashed" patch 3/6 in "mptcp: invoke MP_FAIL response
when needed"
- 3675d85be654: "Signed-off-by" + "Co-developed-by"
- 341e2db12838: tg:msg: update commit message

- efb55524f8bd: mptcp: fix shutdown vs fallback race
- f2084a8aaf07: mptcp: consistent map handling on failure
- 144485c43714: mptcp: fix race on unaccepted mptcp sockets
- Results: 8c6a13817318..972138d95a98 (export)


Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export-net/20220622T203506
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export-net

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20220622T203506
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export


Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
