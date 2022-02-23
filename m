Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FEA7EC
	for <mptcp@lists.linux.dev>; Wed, 23 Feb 2022 03:09:03 +0000 (UTC)
Received: by mail-pf1-f176.google.com with SMTP id x18so14028283pfh.5
        for <mptcp@lists.linux.dev>; Tue, 22 Feb 2022 19:09:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T8hvzWHJX2wv2hbF8sfBZ7kL3wC7nPTxJ8uMv2KMD0Q=;
        b=cp3pz3XauUayBjMLKZsZ0hOjwUTeaUpvuNsgrbBzCPNeOBgCqtGv9CmTq9II1uO6ZR
         hweiE+6JlLrTPaOCLZxr/YgJ/OIoe2Tcma5Vmurig7a7HSz2Q/sJSPcGParIzrMnHEFb
         nVc650sQmsyCM3cis4iD4gRxeP/pVIHTZgL4PSr+l/21pYcV1XwG1OJsaStMsIvs95xi
         2b6RI/w33se/I6PIWkcO6+8MeAMvXesgDRVfwKMhxqAHnpjQ4l4AcxuZINdM2sj2EADm
         XiMlEt1fdKwLKD4x6LE1/ZogauDGTUWKMdHh5lN+ViKuEhaTYqAXqApAHm6IHUJffhrk
         jNSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T8hvzWHJX2wv2hbF8sfBZ7kL3wC7nPTxJ8uMv2KMD0Q=;
        b=tX1SylgNNq6vyIySOCt9E10es36ldm4yxashSI7vXVEeE+DITLtDk2E3Z65ANT9rrg
         wNxbuj2YpXx32FThuhL4Y1sSJcZFo1Z6rOH0Teqz+/1rIPCZmIlKEp4FxEriBmBoXlxJ
         0U49W1eCyTyqKLA9xlnBmHMJ6iLt3+hiK30lyx65yV+jVnpPZoC4JbxqRUX6sY2t7qou
         ozC4M6OF+kvHD16PHR6WXLI88vwHytnyKQa2fJRl0x3e3c8fzwdLsRFqaA26yuuTCkFd
         QB0sw7B+hKGdWPJtFzAIbCrRlEz14i370fnGnYq+NYLBRO8prLm1qQ7FrwsAUGefthdf
         1h0A==
X-Gm-Message-State: AOAM530tUFqihhIKmS01pUhNeJuHll2Kil9MpK4QfHOnXncNJ+/eDz1f
	u+YIPWkQBQiSrqiKdc1nZP7hfpD9aKz0wm2V
X-Google-Smtp-Source: ABdhPJx5TnLcAA4LYZ/U6t5AmQeVu4NOHVepbx9KQ5exCO5gyAwo8fkUzTiFxCUdQdJqU3zBxJjtlw==
X-Received: by 2002:a05:6a00:244f:b0:4cc:a2ba:4cd8 with SMTP id d15-20020a056a00244f00b004cca2ba4cd8mr28145180pfj.74.1645585742854;
        Tue, 22 Feb 2022 19:09:02 -0800 (PST)
Received: from hermes.local (204-195-112-199.wavecable.com. [204.195.112.199])
        by smtp.gmail.com with ESMTPSA id m16sm18288197pfc.156.2022.02.22.19.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 19:09:02 -0800 (PST)
Date: Tue, 22 Feb 2022 19:08:59 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Geliang Tang <geliang.tang@suse.com>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
 mptcp@lists.linux.dev, Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: Re: [PATCH iproute2-next v2 1/3] mptcp: add fullmesh check for
 adding address
Message-ID: <20220222190859.4b79cbf4@hermes.local>
In-Reply-To: <295a693ecc4ec1c3c241db0999d97d8718b7d992.1645584573.git.geliang.tang@suse.com>
References: <cover.1645584573.git.geliang.tang@suse.com>
	<295a693ecc4ec1c3c241db0999d97d8718b7d992.1645584573.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Feb 2022 10:59:47 +0800
Geliang Tang <geliang.tang@suse.com> wrote:

> +			if (adding &&
> +			    (flags & MPTCP_PM_ADDR_FLAG_SIGNAL) &&
> +			    (flags & MPTCP_PM_ADDR_FLAG_FULLMESH))
> +				invarg("invalid flags\n", *argv)

There is a duplicate newline here, the message already gets newline from invarg().
If possible could you give explanation to the user.

Looks like mptcp has this in lots of places, and would be helpful
to give better response.
