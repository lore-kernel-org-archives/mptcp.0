Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916A468
	for <mptcp@lists.linux.dev>; Wed, 15 Dec 2021 15:15:34 +0000 (UTC)
Received: by mail-ed1-f52.google.com with SMTP id y22so5081515edq.2
        for <mptcp@lists.linux.dev>; Wed, 15 Dec 2021 07:15:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:cc:from:in-reply-to:content-transfer-encoding;
        bh=WRuhRKATcY3GADdK/bttqq1afVtj1Ujj7zz+AdMD8zI=;
        b=x0yuXlJJf2xbsTmHSO7943vS2Mx84XK8vxnu209ieXITfRiddA+FePULugrHlSDdFN
         Gt3d7rv5Wtm92LmhM3ZSIA9xbR2eUm9I5j1HiwmiYuCrDSxUMmEarFNrbG/HOXfUhCeE
         k8kLjEo880X7aC8AZ2GC/qP6h/K5OzuhuiR5O+7M/yR77AsZ230cSwIfT45VZoJuxsbt
         GTly/Gwm0N9REVPmwzXknK47XsjJQNOBEGNn7kpdLntWPBOo0hh23a+ReIwrZiyD/sxp
         y/X7AKU1oZ9X00vALQwlwG5RuQJKdxKaurn9Oe2g0H5sCrH3plbayimo2O8PBJlysQB/
         aGtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:cc:from:in-reply-to
         :content-transfer-encoding;
        bh=WRuhRKATcY3GADdK/bttqq1afVtj1Ujj7zz+AdMD8zI=;
        b=VjyUX6cp5RHLS3mrupxSFXW1lPVeho46fhmc/lXwD8FWx8bB8MEHf0sAmaGY2MQC1r
         xsoEZPjR1o3iYxSoDK2JPdcbbWbkLTWehIjpz5xPj/hFUl6/uy4ilGvzhnx4hpodQDxO
         fANRXM4etQ9knMqytZPszOBrJ8gAGP81Co/NWrf+nKggegG5/y344CKQ68nVmXo8ZV2u
         KnKIerB9oFwNjULgMIyV0SuNTuQ0kMm4pvPK3zEOpugh1HsxTZQUutx5OllP7AJZ/bFR
         OegnnXm6BDp7fpNji0wzstTujQaQONdhFFR0wW+ehUF0jxfWHAxq6nbrGL8WtccfINTc
         g+Fg==
X-Gm-Message-State: AOAM533nzLNvZziiibGp0v+klHfIW050M7eMuX6miDk4DPunGYPZ0qdO
	rOnpNGLGkAA9qOs63cS0ro6pDfUG2CWUSw==
X-Google-Smtp-Source: ABdhPJxhpuKnMOOmsRSRNng7nco4QEMnWKRgJFYHPC9XYMuoWLnqvyzX5vykPQFSFm/eQ/UO9j3yRA==
X-Received: by 2002:a17:906:1855:: with SMTP id w21mr285726eje.248.1639581331403;
        Wed, 15 Dec 2021 07:15:31 -0800 (PST)
Received: from [192.168.178.33] (94.105.100.208.dyn.edpnet.net. [94.105.100.208])
        by smtp.gmail.com with ESMTPSA id he14sm766875ejc.55.2021.12.15.07.15.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Dec 2021 07:15:30 -0800 (PST)
Message-ID: <651df38d-49de-6f3d-fca9-b52ccab0c3a5@tessares.net>
Date: Wed, 15 Dec 2021 16:15:29 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v3 mptcp-next] selftests: mptcp: more stable join
 tests-cases.
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>
References: <dfbdb183399851cfa695fa4c965a8d146d436e52.1639567831.git.pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <dfbdb183399851cfa695fa4c965a8d146d436e52.1639567831.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Paolo,

On 15/12/2021 12:36, Paolo Abeni wrote:
> MPTCP join self-tests are a bit fragile as they reply on
> delays instead of events to catch-up with the expected
> sockets states.
> 
> Replace the delay with state checking where possible and
> reduce the number of sleeps in the most complex scenarios.
> 
> This will both reduce the tests run-time and will improve
> stability.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> Note: I still see frequent failures in "remove subflow and signal IPv6",
> but that looks unrelated from this patch: sk lookup fails on the
> client side for the MPJ syn-ack. Funnily enough, I can't reproduce
> the failure with pcap capture on...

Thank you for the new version!

I'm trying it in a loop. So far, so good!


It looks like the CI didn't spot any issues in debug mode but different
ones in non-debug mode:

- KVM Validation: normal:
  - Unstable: 1 failed test(s): selftest_mptcp_join 🔴:
  - Task: https://cirrus-ci.com/task/6235909728239616
  - Summary:
https://api.cirrus-ci.com/v1/artifact/task/6235909728239616/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 1 failed test(s): selftest_diag 🔴:
  - Task: https://cirrus-ci.com/task/4828534844686336
  - Summary:
https://api.cirrus-ci.com/v1/artifact/task/4828534844686336/summary/summary.txt


I guess it is not related to that.


> +rm_addr_count()
> +{
> +	ns=${1}

Small detail: it is not "local". I can fix that when applying the patch
if it helps.

> +# $1: ns, $2: old rm_addr counter in $ns
> +wait_rm_addr()
> +{
> +	local ns="${1}"
> +	local old_cnt="${2}"
> +	local cnt
> +	local i
> +
> +	for i in $(seq 10); do
> +		cnt=$(rm_addr_count ${ns})
> +		[ "$cnt" = "${old_cnt}" ] || break

I was confused by this: why do you stop if it is the same??? But then I
realised it was "||" and not "&&" :)

    [ "$cnt" != "${old_cnt}" ] && break

> +dump_stats()
> +{
> +	echo Server ns stats
> +	ip netns exec $ns1 nstat -as | grep Tcp
> +	echo Client ns stats
> +	ip netns exec $ns2 nstat -as | grep Tcp
> +}

Good idea!

-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
