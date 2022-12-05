Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E0CEB28
	for <mptcp@lists.linux.dev>; Mon,  5 Dec 2022 10:24:22 +0000 (UTC)
Received: by mail-ej1-f45.google.com with SMTP id b2so26589105eja.7
        for <mptcp@lists.linux.dev>; Mon, 05 Dec 2022 02:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CUZ9nPI7P9aViUPdI84KK7DsoJG3DT5DE9U7/G84r/w=;
        b=ypcSZj1bHP6QKzuPPe3CT7vTQLaF3OEddFZsX2ocA9nCPwgAlcsvo9fD435Invf6xW
         DE38M2iIcUPzEWFi4N2Z26gdGvKcT5C6erO9DqR7mMx+VmFeLH20BBn0V91x+b889McO
         RFZ5BeKLrn0xKTjiNy0rc0y4rSYHOEblBrf3rYQ9P89kDSSDbttII1D65z5MfweCU+1r
         YpZPmyoz2Q4NgmqrrvMj3Vgd2ixF5JJW6p5fgfWLniHxDb+kwPfXRH+24owviwSHSJ9u
         tFnamGfJEv4CZZftT6ka7AGJSDL0kUbmHOD7eHM1SpEjM6T34xoUZ7x47M41Gh67Egys
         VWKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CUZ9nPI7P9aViUPdI84KK7DsoJG3DT5DE9U7/G84r/w=;
        b=RZjc/lCIx2dIy8GlBQev4JJ77ZQBWBsOQMAKRJKiqe7q6THRVMYr4ovq3u+Yu8Jj51
         lVpnYff+fZcZLmU5r1gIs0D3TsR/rP6ikuy/01UpMfvUtI40IKeX50/BxYW6a2Cy1YzW
         Jg8IqAbNDvI3t8J7X69Q8KogK5qXrz2ko17uKKhVVxE13a/PaD9azdCB3rwDJib5h8Fx
         M20q9jgb09Lsron/qQ8n2laLBj00W8FtVZRBCzr2NYFUu5nqoZdUQRXksytJwDu4zCC7
         Jo+R0NjGgfX0hv3Dc+BM0nh7UdwowNgmzoExUVDwkJ/qPx3B1qDwMpwgNPx+l/HmHiyc
         KJmQ==
X-Gm-Message-State: ANoB5pmzhTQGf6RbUpVkFvpKPYvjAJMHZm0j7/O7MkWVyt8SRIjF1FmS
	KReB821+z28dbm2xRHi05f4pzqEZfe/jGblPRbU=
X-Google-Smtp-Source: AA0mqf7Lxc9wWVhuKD+r9zhgHOogM+/xl41Ddf7cWDLlz4seTIDTUkEeQvqWZK0w0UD8Deg2a/CLQQ==
X-Received: by 2002:a17:907:1dc6:b0:78d:8533:be13 with SMTP id og6-20020a1709071dc600b0078d8533be13mr67844635ejc.716.1670235861140;
        Mon, 05 Dec 2022 02:24:21 -0800 (PST)
Received: from [10.44.2.26] (84-199-106-91.ifiber.telenet-ops.be. [84.199.106.91])
        by smtp.gmail.com with ESMTPSA id g1-20020a17090604c100b0073dc5bb7c32sm6069847eja.64.2022.12.05.02.24.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Dec 2022 02:24:20 -0800 (PST)
Message-ID: <34f5c12d-8c06-c0ba-56b3-a80c2928add8@tessares.net>
Date: Mon, 5 Dec 2022 11:24:20 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH mptcp-net v2 3/3] mptcp: use proper req destructor for
 IPv6
Content-Language: en-GB
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
References: <20221130094448.4119946-1-matthieu.baerts@tessares.net>
 <20221130094448.4119946-4-matthieu.baerts@tessares.net>
 <92f1e33f-3867-e467-a2f0-f0574529c758@linux.intel.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <92f1e33f-3867-e467-a2f0-f0574529c758@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Mat,

On 02/12/2022 23:56, Mat Martineau wrote:
> On Wed, 30 Nov 2022, Matthieu Baerts wrote:
> 
>> Before, only the destructor from TCP request sock in IPv4 was called
>> even if the subflow was in v4.
> 
> Did you intend "even if the subflow was IPv6." ?

Oops, good catch, thank you, fixed now! (s/in v4/IPv6/)

> Other than that, the series looks good to me. Fine if you fix the above
> when applying.
> 
> Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

Thank you for the review!

Now in our tree (fixes for -net) with Mat's RvB tag:


New patches for t/upstream-net & t/upstream:
- 5819cf24db5f: mptcp: remove MPTCP 'ifdef' in TCP SYN cookies
- 46b00edc3b54: mptcp: dedicated request sock for subflow in v6
- 2df171723dbb: mptcp: use proper req destructor for IPv6
- Results: f48d2409e825..81092f16490f (export-net)
- Results: 9324c815f96d..ec528d5ae7e7 (export)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export-net/20221205T102301
https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20221205T102301

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
