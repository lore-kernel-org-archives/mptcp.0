Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D99371
	for <mptcp@lists.linux.dev>; Wed, 12 May 2021 04:18:54 +0000 (UTC)
Received: by mail-pf1-f182.google.com with SMTP id p4so17655305pfo.3
        for <mptcp@lists.linux.dev>; Tue, 11 May 2021 21:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=e/KivREFHH5UBqsj2M00loF03zTfinW1h9vZmAEb1Yk=;
        b=Tl3w8ikMzy+csMQf466N2XVS5JclMyhYnFSbtINZlP0qUZeOLRIJful0b+GgDJTBg5
         1e4uEcvVkRTJSQRKEi+vDELmwSSqVAM2+BGruE1XfCQSxDQyTtoIliyDzm+TFpmYHQ9O
         G6owqThIHTJKNuve7267sJVhBbuhULUwypV2SG0LLagP7DG1pS3dCeyrskOO2KY4LDI+
         qgLKupoJZZTWI6px6/WaTa+//GJ82Ad09C7YF424DfBhgi3kdBkxzK39Ou9nAHnXz66U
         Ld8J4heA/DaYnCas/8HZ6exl4w9pPspQy1GoaT388KDtcem8i//maGiXgmGWRzfkr5aw
         zw9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=e/KivREFHH5UBqsj2M00loF03zTfinW1h9vZmAEb1Yk=;
        b=N/RSPTmtp7R4zqTjHq60rE0eaUpKDZJaynnpiQ+EULuc7YiV6Cw+RaKpB5LU7/EAEt
         kbqRcF3XrcwJayHVpVEjjjUZUWEEYtJ2FnLmw11Q5xuliwXV33ssd4i/JJexKrNhuVEF
         m8/SV0KUGiCI0eWdXRuxNPlbduzx/ApWH2BeViaOf1EUsPE7e68Wn29uJUXHWzsRY77/
         nUyMK8+VYFzRCcSOE5DxtTwIfqKWabBkvB59NCvh6YJSZF5+DXoX7f984H63l1we4tUo
         GHSQp/+HGLc39ms8F68KcLQZmClLS16LxRtRoNjgedub0Nf4lL/BrY7XTqwnFTAvR18i
         RbXw==
X-Gm-Message-State: AOAM531WvYrit7arb5E/831Wo5McU1O93t9B/hnbOsiCUpJlNo3g3YT0
	2LGDNwD4r3RXh4RVgeFfEEIQHIB1PRoWCUlqsCQ=
X-Google-Smtp-Source: ABdhPJxUdqdCMZ47PWLygtxfmhkk6XooIAbLt/rgwZaWz0+MhOuRHIvXbKHGiOFA//Sqgx4+Vk0L3HtFpjlRgQfzDbQ=
X-Received: by 2002:a65:468d:: with SMTP id h13mr33269878pgr.373.1620793134062;
 Tue, 11 May 2021 21:18:54 -0700 (PDT)
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <694573465901ea0fc5318b379af75f5287a4f77f.1620360953.git.geliangtang@gmail.com>
 <e3d8cbf6-4de3-40da-5442-49d5265f9f5@linux.intel.com> <YJoCFsHJjFSPgE4G@MiBook>
 <a596fc9b-63be-5f71-d92-d3ac3b4e124b@linux.intel.com>
In-Reply-To: <a596fc9b-63be-5f71-d92-d3ac3b4e124b@linux.intel.com>
From: Geliang Tang <geliangtang@gmail.com>
Date: Wed, 12 May 2021 12:18:42 +0800
Message-ID: <CA+WQbwu4_7y41cC_88szs_1HbvWEM62pX0=jw9D+zdQFEqTu6g@mail.gmail.com>
Subject: Re: [MPTCP][PATCH mptcp-next] Squash to "mptcp: generate the data checksum"
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mat,

Mat Martineau <mathew.j.martineau@linux.intel.com> =E4=BA=8E2021=E5=B9=B45=
=E6=9C=8812=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8A=E5=8D=887:17=E5=86=99=E9=
=81=93=EF=BC=9A
>
> On Tue, 11 May 2021, Geliang Tang wrote:
>
> > Hi Mat,
> >
> > On Mon, May 10, 2021 at 05:45:48PM -0700, Mat Martineau wrote:
> >> On Fri, 7 May 2021, Geliang Tang wrote:
> >>
> >>> Move the csum_replace2 trunk into the later patch "mptcp: receive
> >>> checksum for MP_CAPABLE with data".
> >>>
> >>> Signed-off-by: Geliang Tang <geliangtang@gmail.com>
> >>> ---
> >>> net/mptcp/options.c | 3 ---
> >>> 1 file changed, 3 deletions(-)
> >>>
> >>> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> >>> index beac01f58cba..99fc21406168 100644
> >>> --- a/net/mptcp/options.c
> >>> +++ b/net/mptcp/options.c
> >>> @@ -519,9 +519,6 @@ static void mptcp_write_data_fin(struct mptcp_sub=
flow_context *subflow,
> >>>              */
> >>>             ext->data_fin =3D 1;
> >>>             ext->data_len++;
> >>> -
> >>> -           /* the pseudo header has changed, update the csum accordi=
ngly */
> >>> -           csum_replace2(&ext->csum, htons(ext->data_len - 1), htons=
(ext->data_len));
> >>
> >> The commit message above says this is is moved to another patch, but t=
he
> >> posted squash-to patch for "mptcp: receive checksum for MP_CAPABLE wit=
h
> >> data" doesn't add this functionality back. Is a hunk or another squash=
-to
> >> patch missing?
> >
> > Sorry, I didn't describe it clearly.
> >
> > No squash-to patch is missing here, this truck will be moved to another
> > patch automatically when resolving the conflict.
> >
> > Apply this squash-to patch (Squash to "mptcp: generate the data checksu=
m")
> > and rebase, we will get a conflict with "mptcp: receive checksum for
> > MP_CAPABLE with data":
> >
> > $ git rebase --continue
> > Auto-merging net/mptcp/protocol.h
> > Auto-merging net/mptcp/options.c
> > CONFLICT (content): Merge conflict in net/mptcp/options.c
> > error: could not apply d56805c0f705... mptcp: receive checksum for MP_C=
APABLE with data
> >
> > Resolve this conflict like this:
> >
> > '''
> > <<<<<<< HEAD
> > =3D=3D=3D=3D=3D=3D=3D
> >
> >                /* the pseudo header has changed, update the csum accord=
ingly */
> >                if (ext->csum_reqd)
> >                        csum_replace2(&ext->csum, htons(ext->data_len - =
1),
> >                                      htons(ext->data_len));
> >>>>>>>> d56805c0f705... mptcp: receive checksum for MP_CAPABLE with data
> >        }
> > }
> > '''
> >
> > ->
> >
> > '''
> >
> >                /* the pseudo header has changed, update the csum accord=
ingly */
> >                if (ext->csum_reqd)
> >                        csum_replace2(&ext->csum, htons(ext->data_len - =
1),
> >                                      htons(ext->data_len));
> >        }
> > }
> > '''
> >
> > Then the csum_replace2 trunk have been moved to the patch "mptcp: recei=
ve
> > checksum for MP_CAPABLE with data" automatically.
> >
>
> Ok, thanks for the information. In the future if there's a
> conflict-creating squash patch like this it does help to have specific
> conflict resolution notes.
>
> It looks like this chunk of code is not needed at all, though -
> mptcp_make_csum() hasn't been called yet so the pseudoheader has not been
> included in the checksum.

Yes, indeed, I just sent another squash-to patch (Squash to "mptcp: receive
checksum for MP_CAPABLE with data") to drop this chunk.

Thanks.


-Geliang

>
> --
> Mat Martineau
> Intel
