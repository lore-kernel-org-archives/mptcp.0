Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B1170
	for <mptcp@lists.linux.dev>; Fri,  4 Jun 2021 20:31:52 +0000 (UTC)
Received: by mail-ej1-f42.google.com with SMTP id ci15so16335179ejc.10
        for <mptcp@lists.linux.dev>; Fri, 04 Jun 2021 13:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dCNz2gTSVB075aogdEifczLLpyoOX+xEKkWvecuvlds=;
        b=iYumOwH3iQucsQ3oL8yDZpONhO9U1nt2Hz/cXTEj1j0oRNaj8bxtU6QDPt2GjhDDbj
         g+xVvHhRyr04kQGF0viFE2jVmRvH4+Kz1U0l5oIkRSt+dfU7WWh2t99kkwmVwM7wtGcL
         DhVy3lOnSUcwsbF98BX5uP/gqL6vnpQecS8roVDRtTaK0VZW47VL0wZ0q2l4dWxlp7YF
         kckDPa6YFaoHmejHQmVHHqcGWFQFTb7hJe0dJ08h+9Pa4gDZMStmF+SZ9f64mzCv9yez
         u6YmgcukW8fa8w2Uv2AEva96jcdkgiJfZgQJE3KSJEoUAPI+nBLrWbRHAVNzPX6lZuzn
         zJJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dCNz2gTSVB075aogdEifczLLpyoOX+xEKkWvecuvlds=;
        b=FGgr6Fy5RFu509tnqBHwakg8PHtcBMGNbYw4a3CO/z0mmZW9VOHYppcELoNf6JgDD3
         R8EXkg33WAGW0X/XmuJDfPUUCAEKVgXtBC/BqmoMo7U/Q4Yw8St+8wUdrL6lmKoY5w+v
         oAXOoaZmabIpvQBDObcBPmhO1A2ZB4ztGH+w5j+swufJp8PtcI3y0GAyAOoa4l89ZTu3
         rbPlCyDythyQeqv3MCexam3YXtY0nT8vV8QYqgFKrAerZrqgAOi5vYf2cXtsgPX1MsBp
         oUoVt9XDvCjB8lEmNmK0Hl5faOOj/DzD+7C1OMv7wU3sXgBpwFn5Yv2RUUOIHVOnz+OS
         97HQ==
X-Gm-Message-State: AOAM533yGy1CNXX1ID2nzqebWb1IddP+kMsBqblI+GhPtCREMv9c2/Ml
	AnIlKbHh1T0o9acSNtwYhybfuN0TP8eiXjgi
X-Google-Smtp-Source: ABdhPJyeFYvnLhHevUPsPmZZHusNkyj8pI+K3v52x7DqMPeJRFqQuNTf8WwNjvM9uuVeTlAfe0Z+5w==
X-Received: by 2002:a17:906:394:: with SMTP id b20mr5938729eja.108.1622838710434;
        Fri, 04 Jun 2021 13:31:50 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:c047:d46c:d45:3868])
        by smtp.gmail.com with ESMTPSA id n11sm3280261ejg.43.2021.06.04.13.31.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jun 2021 13:31:50 -0700 (PDT)
To: Paolo Abeni <pabeni@redhat.com>,
 Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: fwestpha@redhat.com, mptcp@lists.linux.dev
References: <1a2b1cda55fc38e2143aae3ebab3d9b4e5e5d53f.1622731728.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Re: [PATCH v2 mptcp-net] selftests: mptcp: enable syncookie only in
 absence of reorders
Message-ID: <c106ec25-0c04-5b17-379b-8a60fb196535@tessares.net>
Date: Fri, 4 Jun 2021 22:31:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <1a2b1cda55fc38e2143aae3ebab3d9b4e5e5d53f.1622731728.git.pabeni@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit

Hi Paolo, Mat,

On 03/06/2021 17:09, Paolo Abeni wrote:
> Syncookie validation may fail for OoO packets, causing spurious
> resets and self-tests failures, so let's force syncookie only
> for tests iteration with no OoO.
> 
> Fixes: fed61c4b584c ("selftests: mptcp: make 2nd net namespace use tcp syn cookies unconditionally")
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/198
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Thank you for the patch and the review!

- 48490d1c2717: selftests: mptcp: enable syncookie only in absence of
reorders
- ba645dc88491: conflict in
t/selftests-mptcp-enable-checksum-in-mptcp_connect.sh
- Results: 102ad1154235..ff4906881c2f

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20210604T203059
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export/20210604T203059

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
