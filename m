Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5011FBB
	for <mptcp@lists.linux.dev>; Wed,  3 Aug 2022 16:34:41 +0000 (UTC)
Received: by mail-ej1-f48.google.com with SMTP id tl27so14586266ejc.1
        for <mptcp@lists.linux.dev>; Wed, 03 Aug 2022 09:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=EbR1YFKhUTOJbOrUp9kWPuF/jbusUzUUH3aU6R65iI8=;
        b=M/1lomOZaa3wS0Rc2/7deBHxu3WhPB59xKXrW/zkoQhYkyWENCllUDt0lc9hsQeVhR
         fVejQ4ihyUZp61SoNEgWIr2fOT7yFdwobMJ8hpDHRZobA92NcNQUKVnufxby2AgPVUe9
         rdt3IsenEE6Wcay+S3xfzSG0rtKwGVnKUYHvWrpwvWAQiI1DYJMi3M340xLOWKidg2wj
         ndi0CLY/Zb9JC6piBVWd6+3YVF/QKLggy9jntS3pRf2gP+cKtF00v4YYg/1Z1MLtE2r+
         n7NCgcMiC/NuXMtf+8j5PDWxjHUniZ0dDnCMIaM1s5TMhIO+qrdioqymut4eajskDlwG
         M8ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=EbR1YFKhUTOJbOrUp9kWPuF/jbusUzUUH3aU6R65iI8=;
        b=tB7xdIChiZHJr0rSZXkwQKpGsEgvY8x+3swUM/sR3ovtge+vm5gLkn69PR87ux8VYi
         v5xp39eXxNdepIXMtZ/EPLyzA6lVRj6RIMdEAHhPkY/h4GUHzPUdupm3IrLt3HLvFqt2
         +H3a4mzCkTPfmXVL0n/ezUJSMjSOpQkGT78BVi3UJPtJNnA3d4ByykVBOfe3a9+hJmly
         gEzXuw8c0DKYN4EZt16nXjBRzUCTmHK6EM+j04wKfJlKEuXjIU8UgpKXIJDiAgD9jhYj
         EaxFQP2ymO98rDcdj39H8F5Pt/LwJ/cyohcfNR/peia4aJXIyCXQ60WTl7ktEnPUv+q3
         SW8w==
X-Gm-Message-State: ACgBeo3czGjywELc8bzLfvs6atCpwV2UC1MZ6j9ZhNn047stJvcw2PQx
	eXarohZMeFKgMsrFdOqPn3Lmkg==
X-Google-Smtp-Source: AA6agR6yzFpCiSxF96igMuHSW5+g9xZoky3XHS3vP36CnvvtMwKaQmMOWz5MT2WJyOtD44N13CVlqQ==
X-Received: by 2002:a17:907:2707:b0:730:af0b:3572 with SMTP id w7-20020a170907270700b00730af0b3572mr3073464ejk.411.1659544479840;
        Wed, 03 Aug 2022 09:34:39 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:aec0:3f15:459e:231a? ([2a02:578:8593:1200:aec0:3f15:459e:231a])
        by smtp.gmail.com with ESMTPSA id c13-20020a509f8d000000b0043ba1ecb0dfsm551528edf.75.2022.08.03.09.34.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Aug 2022 09:34:39 -0700 (PDT)
Message-ID: <8ab4af57-e618-19ec-0cc5-1590612bacfc@tessares.net>
Date: Wed, 3 Aug 2022 18:34:38 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.3
Subject: Re: [PATCH v2 mptcp] selftests: mptcp: make sendfile selftest work
Content-Language: en-GB
To: Florian Westphal <fw@strlen.de>, mptcp@lists.linux.dev
Cc: mathew.j.martineau@linux.intel.com, Paolo Abeni <pabeni@redhat.com>,
 Xiumei Mu <xmu@redhat.com>
References: <20220729095550.3040-1-fw@strlen.de>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20220729095550.3040-1-fw@strlen.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Florian, Mat,

On 29/07/2022 11:55, Florian Westphal wrote:
> When the selftest got added, sendfile() on mptcp sockets returned
> -EOPNOTSUPP, so running 'mptcp_connect.sh -m sendfile' failed
> immediately.
> 
> This is no longer the case, but the script fails anyway due to timeout.
> Let the receiver know once the sender has sent all data, just like
> with '-m mmap' mode.
> 
> v2: need to respect cfg_wait too, as pm_userspace.sh relied
> on -m sendfile to keep the connection open (Mat Martineau)

Thank you for the patch and the review!

Now in our tree (fix for -net) with Mat's RvB tag:


New patches for t/upstream-net:
- febacb9a6dd6: selftests: mptcp: make sendfile selftest work
- Results: 17273797344c..06a049f34010 (export-net)

New patches for t/upstream:
- febacb9a6dd6: selftests: mptcp: make sendfile selftest work
- Results: ba0f79895fde..7f8f198f2f9b (export)


Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export-net/20220803T163309
https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20220803T163309


Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
