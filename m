Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF150171D5
	for <mptcp@lists.linux.dev>; Fri,  9 Jun 2023 14:40:07 +0000 (UTC)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-9786c67ec32so317266466b.1
        for <mptcp@lists.linux.dev>; Fri, 09 Jun 2023 07:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1686321605; x=1688913605;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QFGbpcCF1BSO+uFm+o0Jtzd21bDC/BEdoDGFuqwBy6M=;
        b=oTjbSA0vHJmrScOcnHHKTlUvvZwU2+JWhCnDf8UBg8WNdZMZl6xhlNZBuue3UpVqhA
         r+fIYVQJtP+N9D00cUXmL/wih1KDe33c3pgMhlfjnzPyXeMhE/2LzniAOjY6rRGChi5h
         3WiokCw0YzxB0E0YEKDgwdQFisgOxoMVZKHOCMUUn23/QH0WMxako9x9jW3QOzQWPuP7
         3zQnhvinMq64lhIJNqTpMps9ShnQsAOHQfRErGoNcWcA8D3etJEsNhHBNDiA/rBBSIHw
         jOMAAJvI7YXCHsIecFddihaN2/P4m3pVg60x/GSAjuU56s9qcV3itfW550Uaoi1ni809
         ddSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686321605; x=1688913605;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QFGbpcCF1BSO+uFm+o0Jtzd21bDC/BEdoDGFuqwBy6M=;
        b=bhIOjT9gVTeTV13ayCrxRxCqk+liJGIB4qfFtBWGbTy+ca8CEVf52KNNYQ7JfhR6Et
         TuUpwI+gJ2hX1jgG3VbIYtKhtBBgs/ktGnN4Y67jjsi4E+AtH0LGxUieZV0zN/AmUKG/
         noUTnGvuzzpGwbERnohcl9mbKAVdF0ZssIN6SuG0ih0Ds1wRfQX1eGfAb69jmaf6j8r1
         faSk5ItRzR07zOutqA3OtLBkfcVcZeDddKzsISf8ricMEEEi00wHX1hd5e06u+j/IkJj
         wjYSPqfS4DrL41HM3QAYKuHVjCqkllEpfbt/JjYrIXtXSHuOD8G1zS7aR9G+pGKZeSAy
         l37w==
X-Gm-Message-State: AC+VfDxh7qrnr4AzKs6b72tqsnVwYck6vr5i5ZsPpP5FUkCDv1N7zhsF
	S/dCtvDcNyQYoEh05nVoKXmrTT0/e3UB8nA8gTfFWA==
X-Google-Smtp-Source: ACHHUZ4xxcVo4ZQjPv5MWoxYhlBYeKvPedHyoCFjD6kY8uELWghetPtV0th0KT8m4GhRqZejo+YDlA==
X-Received: by 2002:a17:907:9617:b0:974:1ef7:1e88 with SMTP id gb23-20020a170907961700b009741ef71e88mr2507235ejc.13.1686321605525;
        Fri, 09 Jun 2023 07:40:05 -0700 (PDT)
Received: from [10.44.2.5] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id t16-20020a1709064f1000b0096f89fd4bf8sm1361272eju.122.2023.06.09.07.40.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jun 2023 07:40:05 -0700 (PDT)
Message-ID: <f07a9662-6b0a-e23e-8904-138dca7b6c8d@tessares.net>
Date: Fri, 9 Jun 2023 16:40:04 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH mptcp-net 1/2] mptcp: fix possible list corruption on
 passive MPJ
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <f88902bdf5168d86a858575a95882e3fbbadf556.1686155270.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <f88902bdf5168d86a858575a95882e3fbbadf556.1686155270.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 07/06/2023 18:33, Paolo Abeni wrote:
> At passive MPJ time, if the msk socket lock is held by the user,
> the new subflow is appended to the msk->join_list under the msk
> data lock.
> 
> In mptcp_release_cb()/__mptcp_flush_join_list(), the subflows in
> that list are moved from the join_list into the conn_list under the
> msk socket lock.
> 
> Append and removal could race, possibly corrupting such list.
> Address the issue splicing the join list into a temporary one while
> still under the msk data lock.
> 
> Found by code inspection, the race itself should be almost impossible
> to trigger in practice.

Thank you for this patch! It looks good to me.

Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
