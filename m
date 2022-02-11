Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D8A2F26
	for <mptcp@lists.linux.dev>; Fri, 11 Feb 2022 10:33:53 +0000 (UTC)
Received: by mail-ej1-f43.google.com with SMTP id p24so21961918ejo.1
        for <mptcp@lists.linux.dev>; Fri, 11 Feb 2022 02:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=9ZuRZaAls/8wYw49fjwjZLJqn3zwzHYsbTJTU75WFK8=;
        b=cgvQCHyY5grfVNGZucRxw5u/5u0Dow51A3r6rfTAdmEqKkQJq6P5w3QVWYmRQ+WX+X
         TAZAvFQIZaPLsH5hdbwdF4qoT+M0NYJmyvoj+QrIHFyTelh8WwZ9g2T2tq2mTr9XhgOX
         86trOFQEBlc2e2Jg6Xs1vGE1KTvYA8HLSLY0/auzJtj2fN6MT+eHSnq6xWrRkkO8olCl
         oixTme6btZVuqkg+DJg4sMpqEAzZdB+Fzbzae7+uI8Z+KgYvcxYVwT1h8TzCE9JUQH0D
         HJindzPIApO6YgZeTGwFyMbdyRAgqNdsCidqFjnXxGMhApgoj+/D+6QZ1kftpH8jM7NJ
         V27g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9ZuRZaAls/8wYw49fjwjZLJqn3zwzHYsbTJTU75WFK8=;
        b=uGwvUjae7rqqxbpkRS3JdgztapGj1e5docp0Wui+JCDkIiZYyieH8ypn318T7LJ5Rk
         AXdDhtt8CxD/wbW8GzQwC7mNV+V0Yl5INenHEymVxktOOycwC698FzppCen7g0TG6pcl
         1hB+0A7XOiWLmeXTJaJe6ujX0BbzJDX9pHnWqLeeMzRjz9mGy/p3dIfPlw6TJOzFwbTN
         gFVwO03w0fw8NvRV+f2lo8FUJkfxy6+VTzJOnEqVMA2+3I7d8P4uNhW0Y0i3yPILSSm1
         n20uXf+lfDgJB6MFLaae2CV8txlzzz9X4Y41Yx06IfCxtHWdr4QfAHJmiYBh6e7TTM1z
         fZxw==
X-Gm-Message-State: AOAM532ulpLNJPZtirMDAL5eYgyD2NYWdV99KB9ap0OWviiBE8ZgsDWJ
	RJ1kzJ4XBxUmSN7gTedvZD6mlw==
X-Google-Smtp-Source: ABdhPJw/mMfQEKskmGFmVX3DgKHQ9IGObUVFStZVZr5e6YtmDDbOXM1qvU4m3FCuR5zWksYiwvU02Q==
X-Received: by 2002:a17:906:77c6:: with SMTP id m6mr829776ejn.408.1644575631567;
        Fri, 11 Feb 2022 02:33:51 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:fea5:b1fd:66cc:fe97? ([2a02:578:8593:1200:fea5:b1fd:66cc:fe97])
        by smtp.gmail.com with ESMTPSA id bv2sm7813693ejb.155.2022.02.11.02.33.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Feb 2022 02:33:51 -0800 (PST)
Message-ID: <ff4789e4-40d9-1374-53e3-c47954129776@tessares.net>
Date: Fri, 11 Feb 2022 11:33:50 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v3 mptcp-next 0/3] mptcp: more self-tests improvements
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <cover.1644518737.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <cover.1644518737.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Paolo,

On 10/02/2022 19:49, Paolo Abeni wrote:
> This is the new iteration of "mptcp: strict local address ID selection."
> should hopefully fix the last self-test failure.

Thank you for this v3!

I don't know if there is a link but the CI seems to take longer than
usual with these 3 patches.

With a debug kernel config, it even reached the timeout of 55min I set
to start the VM and run all tests:

- KVM Validation: debug:
  - Critical: Global Timeout ❌:
  - Task: https://cirrus-ci.com/task/6256933542821888
  - Summary:
https://api.cirrus-ci.com/v1/artifact/task/6256933542821888/summary/summary.txt

So I restarted it and I didn't reach the timeout:

- KVM Validation: debug:
  - Unstable: 1 failed test(s): selftest_mptcp_connect 🔴:
  - Task: https://cirrus-ci.com/task/5212186606829568
  - Summary:
https://api.cirrus-ci.com/v1/artifact/task/5212186606829568/summary/summary.txt

Still taking longer than usual I think. But that's hard to be sure about
that with these public CI as we don't control where it is executed and
which other tasks are ran in parallel.
Do you observe the same on your side?


BTW, you can see that on this last build, it detected an issue with
mptcp_connect.sh. It didn't detect that with the previous job. That's
probably not related to your modifications. I just noticed it is not the
first time we got the issue (I didn't see it due to the other issues):

- https://cirrus-ci.com/task/6348125144088576
- https://cirrus-ci.com/task/6565756707012608
- https://cirrus-ci.com/task/5501584690905088
- https://cirrus-ci.com/task/6734301743022080
- https://cirrus-ci.com/task/6064315366113280
- etc.

I'm going to create a new issue for that.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
