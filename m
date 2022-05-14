Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCEF2577
	for <mptcp@lists.linux.dev>; Sat, 14 May 2022 17:09:35 +0000 (UTC)
Received: by mail-ej1-f41.google.com with SMTP id bv19so21570520ejb.6
        for <mptcp@lists.linux.dev>; Sat, 14 May 2022 10:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=AWLLUeqQEncY4PcoCGjwU3lvMLkIgsCWBsop4Scf1Rc=;
        b=ClG/IWpbfKwTiA1hdJOv/O0p83bwD6aCzdZTQqT4+wtL3zRDtwDFhxWPU3wryMYfr2
         atG35mLL4HsVvcFaWmJLneHnDpZvuMBDGIdPSOLfch4G1gxa/KFURL4FM7ejRTKdBbPT
         SubRGiefbIFmISfiBPjd//rJLVIcOqTfQdAGFNvUI0EqwgHtt4TrjxZmr3Vo5amzo+u3
         R69gvq+7ILrh55lHqq01+xDZBwIX5IrM1m3fgqGR3fAz5BMe6+YvVRUhtA5+N6Rl4g9N
         SbGtaW+YrJrVw/6T+hxk5aToBzDID9mhfL5T4oFvN9vS/UwqfsFS2x9jxt7h7VafaLNa
         +48g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=AWLLUeqQEncY4PcoCGjwU3lvMLkIgsCWBsop4Scf1Rc=;
        b=QGh+5Tp4ko2ASRPClWWXxT2erwq3SUEFb1VrB9AR44B2u0jdOugy0Z14r6BXeZDw7g
         NwsApzKUq7l7bS1+QUaoMfBHtxAa/SDwTeUNEVavgdPPpbEUMj46GMBWKW9LXH94Yi1q
         ZTlsf3boPDk4QOp9bFGnwqLwIP80qyozbbZiAzjFChwpxUuaPdr7259x22jlOsQ/T+Vg
         4jlglPghP2JzB7A3KJqeW6ciYlyDbUyDQfpQoZlZsyHaB8OYM/dfx7LM8VikXVWn6nuE
         VLiqMDT3b9q/oUdXe4LEDPdZQtusifrfBIXgrD1Z346w6QZbDVReeLygF3/eSn8ifEEU
         EARw==
X-Gm-Message-State: AOAM532Pp7GiUczQItGFncSIPhOL3W1vkoAL+40SSbh2EPgrHRlT673f
	7qLVECh/d+wdPV0FvlM4BqwqLA==
X-Google-Smtp-Source: ABdhPJw7mY77lbQGopD/ElyfBAF75Mne5fvKvv1+mY6cuPfoYIdu0Kq03k9oJBVkJRohUiYCWJHpqw==
X-Received: by 2002:a17:906:3087:b0:6f4:2901:608a with SMTP id 7-20020a170906308700b006f42901608amr9047896ejv.646.1652548173933;
        Sat, 14 May 2022 10:09:33 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:7ae9:144e:df38:3671? ([2a02:578:8593:1200:7ae9:144e:df38:3671])
        by smtp.gmail.com with ESMTPSA id c18-20020a1709063f1200b006f3ef214e35sm1899445ejj.155.2022.05.14.10.09.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 May 2022 10:09:33 -0700 (PDT)
Message-ID: <cb764533-65ca-d2c9-2d65-4d4877e2d64a@tessares.net>
Date: Sat, 14 May 2022 19:09:32 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH mptcp-net v2] mptcp: Do TCP fallback on early DSS checksum
 failure
Content-Language: en-GB
To: Mat Martineau <mathew.j.martineau@linux.intel.com>, mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>
References: <20220511235137.431538-1-mathew.j.martineau@linux.intel.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20220511235137.431538-1-mathew.j.martineau@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Mat, Paolo,

On 12/05/2022 01:51, Mat Martineau wrote:
> RFC 8684 section 3.7 describes several opportunities for a MPTCP
> connection to "fall back" to regular TCP early in the connection
> process, before it has been confirmed that MPTCP options can be
> successfully propagated on all SYN, SYN/ACK, and data packets. If a peer
> acknowledges the first received data packet with a regular TCP header
> (no MPTCP options), fallback is allowed.
> 
> If the recipient of that first data packet finds a MPTCP DSS checksum
> error, this provides an opportunity to fail gracefully with a TCP
> fallback rather than resetting the connection (as might happen if a
> checksum failure were detected later).
> 
> This commit modifies the checksum failure code to attempt fallback on
> the initial subflow of a MPTCP connection, only if it's a failure in the
> first data mapping. In cases where the peer initiates the connection,
> requests checksums, is the first to send data, and the peer is sending
> incorrect checksums (see
> https://github.com/multipath-tcp/mptcp_net-next/issues/275), this allows
> the connection to proceed as TCP rather than reset.
> 
> v2: add a helper function for checking whether a subflow is
> fallback-capable.

Thank you for the patch and review!

I just applied it in our tree (fixes for -net).


I had a conflict with commit f8d4bcacff3b ("mptcp: infinite mapping
receiving"), may you check if the resolution is correct please?


- 88cf15503ba1: mptcp: Do TCP fallback on early DSS checksum failure
- Results: b453c372356a..128393ceec9b (export-net)
- 74a4236c9eae: conflict in
top-bases/t/DO-NOT-MERGE-git-markup-fixes-net-next
- Results: db7207dab3db..9634a3a2eced (export)


Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export-net/20220514T164907
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export-net

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
