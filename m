Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EEF25393
	for <mptcp@lists.linux.dev>; Sat, 19 Feb 2022 12:38:37 +0000 (UTC)
Received: by mail-ej1-f51.google.com with SMTP id p9so21298542ejd.6
        for <mptcp@lists.linux.dev>; Sat, 19 Feb 2022 04:38:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=jR0RzIjCl5K+/PJPebdgzabO2Vu+8NJ/SA5hCzUWJpQ=;
        b=iuaO1b4x6IyfoYrhhGVlmr0ab8zlyxqr5F1AplpTtxmqI+D9zDTmaWJT8KRkt/zx/U
         zqRV2ZNANZrTD5cyi65lo7NCPIi9dP12qXEhE9XUGA84thG3PI8pjiQF7dFU3EZs/a7x
         083TgPG/OPVCcg6IB99eovYCUzkIM/bf444HA2bXDcEENvU+xqUPoYvZDipqE+MvAFod
         3HOUD6VYV+DnslJO0NApbrbIWBYZ/7KcasK82glgrK7fVE+ca8e14l+0NA8ZFR2sRiD5
         h+yew/tP5+bcV/0VjAfdZXz8NAHeaexxCKHrDY2AaItN4D9woZ85DXAsOwgFViKMhBxt
         bLhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=jR0RzIjCl5K+/PJPebdgzabO2Vu+8NJ/SA5hCzUWJpQ=;
        b=ycVmzVkRzJSPBL3+hVqocbYXJfmmRtyRKU1IhE2pKoBtZ81A8zlWkesRFE0lBPoxqi
         NWv68g3juQoTriQqUUri6f03IUDNaECq+An+aAUagKfUcPqqp+VG/Z1gTlTXK+Wukoho
         DNvV1vEQWN0g/Fb9x3X09rf321vsLMdZOwptM+ZdFXTHkBNGholakzTw898Bc62k5diG
         tpFhmISo8pLxb5AKLKFxMF6QM+4xv1WFk8/V/NASGvsw0/0Vy0UCs7vocVqNa8rYeGVm
         cM2gvEyIuUd+sPak5tlm5NQT3T5kKAbJNdFqh/7fmIKimvofh4iK3e4/djP1xkztGE0b
         l81A==
X-Gm-Message-State: AOAM532IrUwU+CzxUm3yMwboC56C0a8SiQsoukHCuyssieNEsqHyNKch
	uklmemUDbVYla6KzitRVvdh0BWigemTDiqkH
X-Google-Smtp-Source: ABdhPJyg7LEEmmA/zP4vmrZJd3tfzAj35n1czdogSqIGF11Se8g8Ph9wwmrmZOmImlMVIcYD/konoQ==
X-Received: by 2002:a17:906:4f0a:b0:6ce:e4fc:34d0 with SMTP id t10-20020a1709064f0a00b006cee4fc34d0mr9758088eju.717.1645274315943;
        Sat, 19 Feb 2022 04:38:35 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:17c5:2ff2:40c3:e649? ([2a02:578:8593:1200:17c5:2ff2:40c3:e649])
        by smtp.gmail.com with ESMTPSA id b7sm5737944edv.58.2022.02.19.04.38.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Feb 2022 04:38:35 -0800 (PST)
Message-ID: <ec7dea0e-36cd-4a47-daf2-ae4e2cb20aa3@tessares.net>
Date: Sat, 19 Feb 2022 13:38:35 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH mptcp-next 0/3] Upstreaming cleanup
Content-Language: en-GB
To: Mat Martineau <mathew.j.martineau@linux.intel.com>, mptcp@lists.linux.dev
References: <20220218221814.72026-1-mathew.j.martineau@linux.intel.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20220218221814.72026-1-mathew.j.martineau@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Mat,

On 18/02/2022 23:18, Mat Martineau wrote:
> The most recent patch series I upstreamed for -net needed a couple of
> tweaks to mitigate net/net-next merge conflicts. The first two patches
> here update the commits in "fixes net" on the export branch to match
> what I sent upstream, and the third patch restores Paolo's function
> rename in mptcp_join.sh.

Thank you for these patches!

I was thinking a bit about how to avoid such "issues" in the future.
Here are some ideas:

- there could be 2 separated trees periodically updated:
  - one for net-next, the one we have for the moment
  - one for -net: a new one
  → all patches for the -net tree would be duplicated in both trees
  → when applying patches in the -net tree, we will notice the conflicts
  → applying the different patches can be automated with the scripts I'm
currently using

- there could be 2 mixed trees periodically updated:


            top

             ^
             |

    commits for net-next

             ^
             |

    merge net + net-next

             ^
            / \
               \
    net-next    \
                 \

                commits for -net (+ commits for the CI)

                   ^
                   |

                  net


  → no duplicated -net commits
  → the "export" branch will be on top of net and net-next
  → "mptcp: use kmalloc on kasan build" could be cherry-picked on top of
the "export" branch for the -net tree not to have it "under" the ones
for net-next.

In both cases, it would be easy to export the different commits and have
different tags that can be used by the CI.

The second case looks interesting to me but there are at least two main
points to be careful with:

 - if the "export" branch is on top of the net-next branch, it means the
patches we have in the tree might no longer apply as is in net-next:
that's the opposite situation as of today where the patches for -net are
on top of net-next. I think that's fine because we would have this issue
in any case if a patch for net-next depend on one that has been
queued/applied in -net but is not in net-next yet.

 - there might be conflicts / build / validation issues from elsewhere
to resolve when merging net-next with -net: conflicts in non MPTCP
parts. They will have to be resolved before they are resolved in
net-next tree. Workaround is not update the "net" base in case of
conflicts until the sync is done by the -net maintainers: easy to put in
place in case of conflicts, a bit less for the build / validation issues
but that's probably rare. A lot of stuff are modified in the -net tree
with all the different protocols, drivers and BPF! It is not rare to
have conflicts if you look at:

  $ git log --grep 'Merge
git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net' net-next

What do you think?
First, do we need a solution?
Then would it be OK with the second solution, especially in case of
conflicts/build/validation issues? If not, would the first solution
helps? Or another one?

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
