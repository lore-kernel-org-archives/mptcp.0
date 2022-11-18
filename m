Received: from mail-lj1-f195.google.com (mail-lj1-f195.google.com [209.85.208.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4C929B2
	for <mptcp@lists.linux.dev>; Fri, 18 Nov 2022 10:17:14 +0000 (UTC)
Received: by mail-lj1-f195.google.com with SMTP id t10so6267002ljj.0
        for <mptcp@lists.linux.dev>; Fri, 18 Nov 2022 02:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Uah8JUfk7FCnhA0WY1r3dvPtLQ4l6yU885/LIFm00o=;
        b=M7YW4Pw/RjRp7htHeFcTtXWKRN6KkiXDLGTXjwPD9QsdjtSf4a40JlWtE94jQ3b43o
         MTR2ij2CNxjTQWycyU/CvWgJYLqb8QWrmgzz3DHYJ+6YJqPKam5sHdBHboYJ9DHB4HCj
         9coFNqzgnmYq+l6dyMegz008yTDwwHEh6wPzOOkgh4FesyY98weSBvNV2LQitFzKVLkx
         tJBncihFN7UiSzeSpQ24BhOTKh8sSWDGWg7aTeVg0DE3pOO5uURiRtLYM3V7VWCCUA1M
         FPotDTpJev0zlNZRKhw+j/WBQVRf4InPBjHV9SgZYdD8TqnCQ0xigO+SuaL3ofDDsOcx
         OFjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Uah8JUfk7FCnhA0WY1r3dvPtLQ4l6yU885/LIFm00o=;
        b=fas+aLVRfmcFrtEgyz7oEfschCeBr9mtBInJCpnkFHDd9TK7vRd9S5gB4PXSCu43Hr
         w6y5FLt8Qdzg7lus+yZsg5aZd5xSiJJGUloLSN/tEFp2XgAHqBRzsqqld6aiQNv1iVgU
         P0H/gCQFip+7xPU6HefX9lKVLTywUQg5GKvPLSAX7FFQxkvUN/Z0UuHLCxILDYZcolR8
         JHXg2uHRoIUL/U6P8SrQIq506+t7hS2V9AyFjOQt54bBj3eyP3TYhgLCd36zImQ/RIRJ
         VblMUmjDGuUIba0oLi6HG2tXgjkDYqqyVArPnpEL4k/cUelppWaSARRPqWifYxJ0NnTt
         qS8w==
X-Gm-Message-State: ANoB5pkYsbL4ApAY9y/U7tynF17j/FM9XWgaUEke0PrfoWlOwlTTWtXu
	nWE6SvTh+a4I1XUaOE/l3nLCeCzM5WqnsoOkP3M=
X-Google-Smtp-Source: AA0mqf43MuY9VXf5oMeb1ZO6pwwKq65RySmaCYxTOKC77jfvvbak/VsdM2vm476gEjuQ2UYfgXlgMor+ZqtymTnpehA=
X-Received: by 2002:a05:651c:b26:b0:277:9847:286a with SMTP id
 b38-20020a05651c0b2600b002779847286amr2159219ljr.309.1668766632938; Fri, 18
 Nov 2022 02:17:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20221118072030.3500578-1-imagedong@tencent.com> <26bbecbd-bc79-e206-e3d7-bb7ba804a4c0@tessares.net>
In-Reply-To: <26bbecbd-bc79-e206-e3d7-bb7ba804a4c0@tessares.net>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Fri, 18 Nov 2022 18:17:01 +0800
Message-ID: <CADxym3agPigz_-UsNv=0pEpw0qRM+TnWD-O1d9zWLsmJZZ0e-Q@mail.gmail.com>
Subject: Re: [PATCH mptcp-net] mptcp: don't orphan ssk in mptcp_close()
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: pabeni@redhat.com, mathew.j.martineau@linux.intel.com, 
	mptcp@lists.linux.dev, Menglong Dong <imagedong@tencent.com>, 
	Biao Jiang <benbjiang@tencent.com>, Mengen Sun <mengensun@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 18, 2022 at 6:10 PM Matthieu Baerts
<matthieu.baerts@tessares.net> wrote:
>
> Hi Menglong,
>
> On 18/11/2022 08:20, menglong8.dong@gmail.com wrote:
> > From: Menglong Dong <imagedong@tencent.com>
> >
> > All of the subflows of a msk will be orphaned in mptcp_close(), which
> > means the subflows are in DEAD state. After then, DATA_FIN will be sent=
,
> > and the other side will response with a DATA_ACK for this DATA_FIN.
> >
> > However, if the other side still has pending data, the data that receiv=
ed
> > on these subflows will not be passed to the msk, as they are DEAD and
> > subflow_data_ready() will not be called in tcp_data_ready(). Therefore,
> > these data can't be acked, and they will be retransmitted again and aga=
in,
> > until timeout.
> Thank you for the patch.
>
> I don't know if you noticed but the CI found an issue with it:
>
> - KVM Validation: debug:
>   - Unstable: 1 failed test(s): packetdrill_add_addr - Critical: 1 Call
> Trace(s) =E2=9D=8C:
>   - Task: https://cirrus-ci.com/task/6018056502116352
>   - Summary:
> https://api.cirrus-ci.com/v1/artifact/task/6018056502116352/summary/summa=
ry.txt
>
> Do you mind looking at that please?
>

Yeah, I noticed it. Seems the ssk is using msk->sk_socket, which will
be freed after mptcp_close(). I'm still thinking :/

Thanks!
Menglong Dong

> Cheers,
> Matt
> --
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
