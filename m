Content-Type: multipart/mixed; boundary="===============6319309553193355018=="
MIME-Version: 1.0
From: Matt <mattator at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: Android phones with MPTCP
Date: Mon, 16 Nov 2020 14:20:47 +0100
Message-ID: <CADHp1Nz_OThAPVQiQcvFE+JEVCRdhVEDk55+w5zB1SNhhcA6fA@mail.gmail.com>
In-Reply-To: CAOenT2NzFcJhotVGezxZ-h039ZUir-MmropoFdBMH52UD+0p3w@mail.gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6753

--===============6319309553193355018==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

It's not an android but still a smartphone I believe
https://puri.sm/products/librem-5/ could do it.

Le lun. 16 nov. 2020 =C3=A0 11:25, Marios Choudary
<marios.choudary(a)gmail.com> a =C3=A9crit :
>
> Thanks a lot for the information Matt.
>
> Best wishes,
>   Marios
>
> On Fri, Nov 13, 2020 at 6:47 PM Matthieu Baerts <matthieu.baerts(a)tessar=
es.net> wrote:
>>
>> Hi Marios,
>>
>> On 12/11/2020 18:15, Marios Choudary wrote:
>> > Could you please help me with a list of Android smartphones that suppo=
rt
>> > MPTCP ?
>>
>> This project is about MPTCP in the upstream Linux kernel. The work is in
>> progress and the inclusion started in Linux 5.6. It is a rework of a
>> fork that was started a few years ago. More details in our wiki:
>>
>> https://github.com/multipath-tcp/mptcp_net-next/wiki
>>
>> You then need to find a phone using a kernel >=3D5.6
>>
>> > I would prefer to know about recent models, either Samsung or Google
>> > Pixel, but if there is some comprehensive list that would be great as =
well.
>>
>> To my knowledge, most recent phones are using a kernel 4.19 or older. In
>> Android, they are usually using the LTS version. The next ones are v5.4
>> and v5.10.
>>
>> Also I heard that at Linaro, they have a project to use the mainstream
>> kernel:
>>
>> https://www.linaro.org/blog/aosp-on-pixel3-pocof1-running-aosp-with-main=
line-kernel-on-form-factor-devices/
>>
>>
>> If you are interested by the out-of-tree kernel (mptcp.org), another
>> company should release a kernel with MPTCP (fork) for the PocoF1. No
>> idea when.
>> One last thing, some phones have MPTCP support (Apple, some Samsung,
>> Huawei, LG, etc.). For the Android ones, you certainly need extra
>> permissions to be able to use MPTCP and configure it. I don't have a
>> list for that, you need to check the source code of their kernel to see
>> if the folder "net/mptcp" exists.
>>
>> If you have questions about that, the best is to ask them on the ML
>> linked to this other project:
>>
>> mptcp-dev(a)listes.uclouvain.be
>> http://multipath-tcp.org/
>>
>> Cheers,
>> Matt
>> --
>> Tessares | Belgium | Hybrid Access Solutions
>> www.tessares.net
>
> _______________________________________________
> mptcp mailing list -- mptcp(a)lists.01.org
> To unsubscribe send an email to mptcp-leave(a)lists.01.org
--===============6319309553193355018==--
