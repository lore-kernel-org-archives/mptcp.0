Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DEB47E
	for <mptcp@lists.linux.dev>; Thu,  3 Mar 2022 15:28:27 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id c16-20020a17090aa61000b001befad2bfaaso4679314pjq.1
        for <mptcp@lists.linux.dev>; Thu, 03 Mar 2022 07:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=H5rASoVTlTD2V2UWR5hTz1rw1gk2l/aPiH4KAtsWEaE=;
        b=aDiqF/NY1Wo7+Vn3UUgBPuaGcRDF5JFRcnVT2kCNK9LF5XXprXJTSOC62dg/TCuXd9
         Hdrwc9Wc3xNd/OvrfOOJo9MuYldYIR60ZYUXG0tZ8H7ucGR7XN5/xNEG/KJg9xbtZrcn
         qzOp8cczGNRBtPysP7AofOYAjNe/pn6Wfy5MqFBtDqkAz4K5pmWs39H6ywP7q7YgPMw0
         RjUa5wzDF9cuCii5Y/MQl3vPbg5r+RHqfDHc6lIz/dS/wrX11AhOlQdmnjcSW+TgZTJT
         VRj7m7qghiV8jBiA0Cj3j7B+0+MceRU73WobnNQXzJFm2uy1mxZLJXzTFELoAYY/IfKL
         u78g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=H5rASoVTlTD2V2UWR5hTz1rw1gk2l/aPiH4KAtsWEaE=;
        b=cdU+RkdAPafvp9UNVWyKYNpIHxhQ4+VZhUFnebZZMm1WHhSo9qMXFIipy6nJnsIS73
         qRM2dHm/HCem1W2cVaVUhBPINq3Mm0kl+/6dnZ6lkzdvkzOB4ePRqrIpuauOd+bOTM8b
         ryysghESYgQ4BDBJVQ2B13HcWoOpAlWhnCGG2xeVr5OjI976Ic5l4WE7xkitktsX+UFo
         BrVXs6Bb2jzK2/a2Efkj0nfGZtYaoVKHuKNNIVOXrWoX4FkzeCQZYuCxnJrUb7LK43UK
         bHnYElOpvfRKlOpr0btApeJMkTwiamNHaxtLCHJDvahwAYR1Fay/6Rr2d1tGczu5BGUX
         KWRQ==
X-Gm-Message-State: AOAM532+MiWoNBHxIziJ9gLrGyxBMC0+c+PPx2LYrVNbIKCoDMNPu6J2
	JSW0Vof6ydIu5rsfJDJ28oHDzHfY0Pu73UZGRAarbrY9
X-Google-Smtp-Source: ABdhPJwrtwnw1YRkoeC5tIidjecB9rOZTeu5bTxoV+V4K/YO0ypTJGKbQoHtxrhPfis1jOcURjEbCyeagPELsM7Uw1A=
X-Received: by 2002:a17:902:6acc:b0:149:8f60:a526 with SMTP id
 i12-20020a1709026acc00b001498f60a526mr37806027plt.25.1646321307036; Thu, 03
 Mar 2022 07:28:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1646320786.git.geliang.tang@suse.com> <9475684e-8425-7992-7549-56ee6ea31872@tessares.net>
In-Reply-To: <9475684e-8425-7992-7549-56ee6ea31872@tessares.net>
From: Geliang Tang <geliangtang@gmail.com>
Date: Thu, 3 Mar 2022 23:28:15 +0800
Message-ID: <CA+WQbwvRzybELEb-qz=FW+xPim5=kvNvwPg0u4Je0+LyaXr8dw@mail.gmail.com>
Subject: Re: [PATCH RESEND mptcp-next v5 0/3] new bpf_mptcp_sock()
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: Geliang Tang <geliang.tang@suse.com>, MPTCP Upstream <mptcp@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Matthieu Baerts <matthieu.baerts@tessares.net> =E4=BA=8E2022=E5=B9=B43=E6=
=9C=883=E6=97=A5=E5=91=A8=E5=9B=9B 23:26=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi Geliang,
>
> On 03/03/2022 16:22, Geliang Tang wrote:
> > RESEND:
> >  - fix the CI Build Failure.
>
> For the next series, may you bump the version instead of using 'RESEND'.

Sure!

>
> It would be clearer. Bumping the version is not costly and typically,
> 'RESEND' means "resending the exact same content, potentially rebased".
>
> Cheers,
> Matt
> --
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
>
