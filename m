Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39463C8A
	for <mptcp@lists.linux.dev>; Mon, 14 Feb 2022 20:50:08 +0000 (UTC)
Received: by mail-pf1-f180.google.com with SMTP id c4so9960958pfl.7
        for <mptcp@lists.linux.dev>; Mon, 14 Feb 2022 12:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=SrKpZub/7nRYUSzBNGNZw8emoGFNEd8m8/XuI1W2r9E=;
        b=qYejSSES1Y9u+zhzkW7yvV1voWLLhSWeq/1vW2PeKal+uiUNm4ld1OjCesV8jPxAil
         QU4I1tlHHDxjSwq8Wc5vULDs1CUuTQAGVUvfTMCtNIjBiY5H26SFshZRsvaEcRLUwc+s
         BT+DnZXNNGVKJQ/SHYmSpXu7Xvkb8Y0kWwdiCG0lAcX/ofb9XHFsbzuraglX+qVqQZp7
         fA2FDyY6jWQI6KO2KnyNqDpfZLpDjTV7La3q/n0/PcBLhGKeV2Mx8l8YzNdmzDcyGZJ4
         BzDQIqPw6RXhKTVBNHoEJ0uSAkrCqJ98VSv1AaGWLIAVTCjC9rQ6SUO2gcTNmJAOzzXv
         qYcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=SrKpZub/7nRYUSzBNGNZw8emoGFNEd8m8/XuI1W2r9E=;
        b=DqEo1xX4nZXJw+1n6Avra+erc5wSC/g50if0LHOoXCIVGXh0HSBxx+7/UVx3SO8/oQ
         v9p6hdgTdi5dJprf6lZ3F5jwMScPps4RLgZIgXbT+NsWwdlc5d7loPZnx77N//n/hwiV
         dTp5WyU9+RMcRBoYEYbBA/mkmJmJ21s8kEYQKdaF0h3X65abCbWlFMD5F4zVajtOmNnA
         cH5gCRVJVvmvqgKoLMKZMYDE28Jg+X/cO5qXARXZQKw7AqcoHFnM0vFziE1PNLAb2uZ4
         MiK38Yl6COaliZ7cMGo3ImrPPMzG9mI4qDdW/8lQujIic5eg7g3B6FCB5pKwU9bZuqs2
         fr0w==
X-Gm-Message-State: AOAM531FpQg7nJ1CJ6+hcirlSbqZ80fO1RrIed3t2jBnJ1w4Q+XrQwlE
	84ROFTRp1dCdR9BPKEGzAA==
X-Google-Smtp-Source: ABdhPJxXjQlChMQtM0LKJfKzb+IiSawAvCHAI9gF+pmrX629FjcV1qXDGy+Evl1sc0w/Y1EobKe2jw==
X-Received: by 2002:a05:6a00:1251:: with SMTP id u17mr728746pfi.8.1644871807730;
        Mon, 14 Feb 2022 12:50:07 -0800 (PST)
Received: from [127.0.0.1] ([20.69.155.41])
        by smtp.gmail.com with ESMTPSA id q2sm39739472pfj.94.2022.02.14.12.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 12:50:07 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Alex Maydanik <alexander.maydanik@gmail.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20220212102927.25436-1-alexander.maydanik@gmail.com>
References: <20220212102927.25436-1-alexander.maydanik@gmail.com>
Subject: Re: net: fix documentation for kernel_getsockname: Build Failure
Message-ID: <181e1207-aa3f-a5c6-d564-e3edae4dd807@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Feb 2022 20:50:07 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Alex,

Thank you for your modifications, that's great!

But sadly, our CI spotted some issues with it when trying to build it.

You can find more details there:

  https://patchwork.kernel.=
org/project/mptcp/patch/20220212102927.25436-1-alexander.maydanik@gmail.=
com/
  https://github.com/multipath-tcp/mptcp_net-next/actions/runs/1843188=
936

Status: failure
Initiator: MPTCPimporter
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/ec18713d1f5d

Feel free to reply to this email if you cannot access logs, if you need
some support to fix the error, if this doesn't seem to be caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
