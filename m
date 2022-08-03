Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1F720E4
	for <mptcp@lists.linux.dev>; Wed,  3 Aug 2022 16:39:12 +0000 (UTC)
Received: by mail-ej1-f49.google.com with SMTP id y13so18461081ejp.13
        for <mptcp@lists.linux.dev>; Wed, 03 Aug 2022 09:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=g3bVZ71Zlo5145vc434tb+cR1cvPDbr4Imj/Y8MaeMs=;
        b=IiSL77BhUYWqwZQiEdZJo9blkxF68IdD30g8z7C+JuLZoKcG0xGZrrrgmUyqwqOHck
         pVswVwCG1BK8NCHv5KQvpKABSti07vwoqLWFbjfSjURFMJUmEHHJ9EFXAV5JL2JikAwG
         mBv1rY47Fuerda9V4HVwOdtKlIawqkqQH9OBWEiauSl93nCbRnVEmGs91P3cYqilcoln
         7ciLqqgINQwxd6IE/C3EpqTctzKNfGm/he/oPvnvaaA7rMIqPZJ0qcqMlGc7KRkRCxk1
         PoNP+vfd4HRhDR11R7lnEfi0ZTqIHbAoah2VMrrvkar8SQuLoEaePl0CtqrdszbIN7jA
         Nwrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=g3bVZ71Zlo5145vc434tb+cR1cvPDbr4Imj/Y8MaeMs=;
        b=74cr5RImhHW4cLBuMNDn22e+aRejywojltmh6GzO2eEAIC+VMIaIkJ3eNHqJ92sqGv
         QwO6f8lj4xyYobr9XcLz8K8LtGS/gmRgzXfBP5q4h2nad75Bhlh/liWyUHNMEO1vMGn0
         MWIRc7qmFYEwVOZRXoABz3yQqMY07rcbd1PEbg/62HHzLeUmwvbNxbhBv4pp2kyuqrEr
         HmLwx+yEV3RiWRLgoSKV4bglhBjVORhpQJQg5ai0VOoE2mMmtRRmDGkf+bClotSkSXNx
         zmnzDPB2rjH9O2vddmorUvwgss6oVElbfsGMBhMKYKLBWyz465LuATgxhk9g1Tsj0MAu
         6XpQ==
X-Gm-Message-State: ACgBeo1pCIGLAcr0q1kc0qLPAmJsi1UTw2gH2fp6LR+9Z83rWtZxE1xG
	6+EpoGMm1+U0BEuPa89BusbMRA==
X-Google-Smtp-Source: AA6agR5FoVBN+pcQvIeg27I1ChKvLz1MeC29Mgp0fQ3eOTOuuQ/GrJJLfZ+qMFhHum9HQI2yDhx6CQ==
X-Received: by 2002:a17:906:cc50:b0:730:b5fd:89cf with SMTP id mm16-20020a170906cc5000b00730b5fd89cfmr2550574ejb.221.1659544750476;
        Wed, 03 Aug 2022 09:39:10 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:aec0:3f15:459e:231a? ([2a02:578:8593:1200:aec0:3f15:459e:231a])
        by smtp.gmail.com with ESMTPSA id wc7-20020a170907124700b0072b55713daesm3680363ejb.56.2022.08.03.09.39.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Aug 2022 09:39:10 -0700 (PDT)
Message-ID: <60c71e23-7ac5-ce37-2612-0cf5280a317b@tessares.net>
Date: Wed, 3 Aug 2022 18:39:09 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.3
Subject: Re: [PATCH v3 mptcp-next 0/4] mptcp: just another receive path
 refactor
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <cover.1659165378.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <cover.1659165378.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo, Mat,

On 30/07/2022 10:04, Paolo Abeni wrote:
> This is a refresh and rebase of an already shared work:
> 
> https://lore.kernel.org/mptcp/cover.1621963632.git.pabeni@redhat.com/
> [1]
> 
> The motiviation for refreshing this is:
> 
> https://lore.kernel.org/mptcp/YtVhyGSsv1CWvPz4@xsang-OptiPlex-9020/
> 
> specifically it looks like that properly attaching mem_cg to the
> msk socket would be (much?) easier if the RX path and the fwd memory
> allocation would be under msk socket lock protection.
> 
> The first 2 patches are proably worthy even without the refactor,
> but specifically the 2nd one is required to get a good mptcp-level
> acking behavior when we move the rx under the socket lock.
> 
> The 3rd patch does the real work, and the 4th is a follow-up cleanup.
> 
> Back at [1], I measured relevant performance regressions in some
> specific cases. I've done the same test here and I now see little to
> noise changes. I guess that is mostly due to the better acking
> strategy already introduce with commit 949dfdcf343c ("Merge branch 
> 'mptcp-improve-mptcp-level-window-tracking'") and refined here.
> 
> Paolo Abeni (4):
>   mptcp: move RCVPRUNE event later
>   mptcp: more accurate receive buffer updates
>   mptcp: move msk input path under full msk socket lock
>   mptcp: use common helper for rmem memory accounting

Thank you for the patches, the review and breaking MPTCP selftests again :-D

These patches have just been applied in our tree (feat. for net-next)
with Mat's RvB tags and without a typo (s/acconting/accounting) detected
by codespell.


New patches for t/upstream:
- 6ad19008277f: mptcp: move RCVPRUNE event later
- 02da15069287: mptcp: more accurate receive buffer updates
- 187f1240938a: mptcp: move msk input path under full msk socket lock
- e81d36defc24: mptcp: use common helper for rmem memory accounting
- Results: 7f8f198f2f9b..fc2b3f4211d6 (export)


Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20220803T163817


Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
