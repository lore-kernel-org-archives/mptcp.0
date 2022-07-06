Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C75A258B
	for <mptcp@lists.linux.dev>; Wed,  6 Jul 2022 17:14:33 +0000 (UTC)
Received: by mail-ed1-f42.google.com with SMTP id m16so4622917edb.11
        for <mptcp@lists.linux.dev>; Wed, 06 Jul 2022 10:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=qBTloUL2f4MVh7+Yy4+N8GBOBeIaNURH52HXFvRbU/U=;
        b=C01VeB8Q3g9CjKGikIN8GWqxI9pc8Xqksl+Ntyqu9l49LS5KvMvXCCVsvQHy1n3YbD
         zhtXSuJSzQKHvvLHNRpSG0QqadYx0VoBYT6rG68MFO1vrilkWah3+uKumek5DuWg8i/W
         V/MVR8mR94RaNWKJBMrZpTwiMMI3dPVdFfVVXecJ9bTmrCjVefs7+JtthWNM0blv2WJ8
         YCY2EvTEzdCOxlvYS1IHncEk2t28/AVwDFPQw1mbP/8X9HHiLI0eJ1O1GKejwzaJjz8q
         pA0ue2zfeHChNnv1xthVo/R4Kzygm3gNLrPEY63BOtNtj3wbfkd+UoTU+ykA3yrbQKcp
         Qd0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=qBTloUL2f4MVh7+Yy4+N8GBOBeIaNURH52HXFvRbU/U=;
        b=1GS9zIY85yEQscrUPOIaGqtyso6wpndKruT8XPVAAa+1a410FMA0hhTs7f7DthdDdv
         M77KCn4m+/VkMrT79OTpxmlo4igzHpmvjZgF4Orko84Mr1uXqyVj32PzH9ZL2PylAOX7
         STmSk2XXabnCHBhkL8iNDzftoMzI4QTX7z//1Pn7xEaCjPlNH6YNUL0ZptdOO4lY0Rp4
         /iipbQHHXIXnZRpat7NUMBc/OXq57sTusHQeH/+Xtj3IqXx9FWMDJG9As7j2f1lvE75x
         MNUSYN/Yi5wSxzV4viKZof3+rC8Yb3TIIuBRePc7sX1/XDRYrVDmkrKowF8641ZO7raO
         J7Lg==
X-Gm-Message-State: AJIora9Xb52jmH1Q/y3RQyp+CwAZnUd2Rq7ek4c93FkKlIBAuPKRjDTv
	q0TWTSoilWd+H8GCQCy9lJjBEtjHRG030am1
X-Google-Smtp-Source: AGRyM1tTWPo9v29PQr+KS3lfMHmu3SMGhfmfLrdqFPc1pynC8DWSS4pB5KuPuDtDudeBiyhdVWW5wA==
X-Received: by 2002:a05:6402:b9b:b0:43a:5aac:ed6 with SMTP id cf27-20020a0564020b9b00b0043a5aac0ed6mr22636704edb.131.1657127671662;
        Wed, 06 Jul 2022 10:14:31 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:c688:fc49:57d7:6b4c? ([2a02:578:8593:1200:c688:fc49:57d7:6b4c])
        by smtp.gmail.com with ESMTPSA id kz11-20020a17090777cb00b0072af18329c4sm1802263ejc.225.2022.07.06.10.14.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jul 2022 10:14:31 -0700 (PDT)
Message-ID: <54664e84-80a5-cdc9-df37-db1e93fb72ee@tessares.net>
Date: Wed, 6 Jul 2022 19:14:30 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 mptcp-next 0/5] mptcp: support for MPC prio exchange
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <cover.1656925387.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <cover.1656925387.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo, Mat,

On 04/07/2022 11:14, Paolo Abeni wrote:
> This series introduces the ability to control the MPC subflow for
> the in kernel PM.
> 
> patch 1 && 2 refactor a bit the endpoint lookup and MP_PRIO generation
> code, to simplify the next patch.
> 
> patch 3 introduces the new feature quering the backup status of the
> endpoint used by the MPC subflow and eventually generating the needed
> MP_PRIO option.
> 
> Patch 4 is a related cleanup.

Thank you for the patches and the reviews!

Now in our tree (feat. for net-next) with Mat's RvB tag and without 2
small issues reported by checkpatch.

New patches for t/upstream:
- 063213e73149: mptcp: introduce and use mptcp_pm_send_ack()
- 69bc499efccb: mptcp: address lookup improvements
- 0417a959d55e: mptcp: allow the in kernel PM to set MPC subflow priority
- 084ba8b4dc1a: mptcp: more accurate MPC endpoint tracking
- 267566754670: selftests: mptcp: add MPC backup tests
- Results: c47b82c7b9aa..7d868133e0d9 (export)

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20220706T170628
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
